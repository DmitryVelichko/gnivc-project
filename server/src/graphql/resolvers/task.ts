import { Op } from 'sequelize';
import { intersection, map, pickBy } from 'lodash';
import { ForbiddenError } from 'apollo-server-express';

import { checkAuthorization, checkEntityExistence } from '../../utils/premissoins';
import { removeFile, saveFile } from '../../utils/files';
import Skill from '../../database/models/skill';
import Task from '../../database/models/task';
import User from '../../database/models/user';
import File from '../../database/models/file';
import { getFilter, getTask, setSkills } from '../../utils/db';

const taskOptions = {
  include: [
    { model: Skill },
    { model: User, as: 'owner' },
    { model: User, as: 'selectedApplicant' },
    { model: User, as: 'applicants' },
    File,
  ],
};

module.exports = {
  Mutation: {
    async createTask(_, { input }, user: User = null) {
      checkAuthorization(user);

      const task = await Task.create({
        ...input,
        ownerId: user.id,
        status: 'created',
        views: 0,
      });

      if (input.skills) {
        await setSkills(input, task);
      }

      if (input.attachments) {
        await Promise.allSettled(input.attachments.map((file) => saveFile(file, task.id)));
      }

      return task;
    },
    async updateTask(_, { input, id }, user: User = null) {
      const task = await getTask(user, id, 'created');

      if (input.newAttachments) {
        await Promise.allSettled(input.newAttachments.map((file) => saveFile(file, task.id)));
      }

      if (input.oldAttachments) {
        const files = await File.findAll({ where: { id: input.oldAttachments } });
        files.map(removeFile);
        await Promise.allSettled(files.map((file) => file.destroy()));
      }

      if (input.skills) {
        await setSkills(input, task);
      }

      const updateFields = pickBy(input, (val, key) => !['newAttachments', 'oldAttachments'].includes(key));
      await task.update({ ...updateFields });

      return task;
    },
    async offerTask(_, { id }, user: User = null) {
      const task = await getTask(user, id, 'created');
      return task.update({ status: 'offered' });
    },
    async unOfferTask(_, { id }, user: User = null) {
      const task = await getTask(user, id, 'offered');
      return task.update({ status: 'created' });
    },
    async assignTask(_, { taskId, applicantId }, user: User = null) {
      if (user?.id === applicantId) {
        throw new ForbiddenError('Owner of task cannot be applicant of the own task');
      }

      const task = await getTask(user, taskId, 'offered');
      const applicant = await User.findByPk(applicantId);
      checkEntityExistence(applicant);
      return task.update({ status: 'assigned', selectedApplicantId: applicantId });
    },
    async unAssignTask(_, { taskId }, user: User = null) {
      const task = await getTask(user, taskId, 'assigned');
      return task.update({ status: 'offered', selectedApplicantId: null });
    },
    async startTask(_, { taskId }, user: User = null) {
      const task = await getTask(user, taskId, 'assigned', 'applicant');
      return task.update({ status: 'started' });
    },
    async cancelTask(_, { taskId }, user: User = null) {
      const task = await getTask(user, taskId, 'started', 'applicant');
      return task.update({ status: 'canceled' });
    },
    async completeTask(_, { taskId }, user: User = null) {
      const task = await getTask(user, taskId, 'started');
      const applicant = await User.findByPk(task.selectedApplicantId);
      await applicant.$add('learnedSkills', await task.$get('skills'));
      return task.update({ status: 'completed' });
    },
    async deleteTask(_, { taskId }, user: User = null) {
      const task = await getTask(user, taskId, 'created');
      (await task.$get('attachments')).forEach((file) => removeFile(file));
      await task.destroy();
      return true;
    },
  },

  Query: {
    async getTask(_, { id }: { id: number }) {
      const task = await Task.findByPk(id, taskOptions);
      checkEntityExistence(task);
      await task.update({ views: task.views + 1 });
      return task;
    },
    async findTasks(_, { input }) {
      const where = {
        ...(input.owner && { ownerId: input.owner }),
        ...(input.status && input.status.length ? {
          status: {
            [Op.and]: {
              [Op.in]: input.status,
              [Op.not]: 'created',
            },
          },
        } : { status: { [Op.not]: 'created' } }),
        ...((input.priceFrom || input.priceTo) && getFilter(input, 'price')),
        ...((input.dueDateFrom || input.dueDateTo) && getFilter(input, 'dueDate')),
        ...((input.weightFrom || input.weightTo) && getFilter(input, 'weight')),
      };

      return Task.findAndCountAll({
        offset: input.offset,
        limit: input.limit,
        distinct: true,
        where,
        include: [
          {
            model: Skill,
            ...(input.skills && input.skills.length && {
              where: { id: { [Op.in]: input.skills } },
            }),
          },
          { model: User, as: 'owner' },
          { model: User, as: 'selectedApplicant' },
          { model: User, as: 'applicants' },
          File,
        ],
        ...(input.orderBy && { order: [[input.orderBy, input.orderDirection || 'DESC']] }),
      });
    },
    async getOwnTasks(_, __, user: User = null) {
      checkAuthorization(user);
      return user.$get('ownTasks', taskOptions);
    },
    async getParticipatedTasks(_, __, user: User = null) {
      checkAuthorization(user);
      return user.$get('participatedTasks', taskOptions);
    },
    async getInterestingTasks(_, __, user: User = null) {
      checkAuthorization(user);
      const userWantedSkillIDs = (await user.$get('wantedSkills')).map((skill) => skill.id);

      const interestingTasks = await Task.findAll({
        where: { status: 'offered' },
        include: [
          {
            model: Skill,
            where: {
              id: { [Op.in]: userWantedSkillIDs },
            },
          },
          { model: User, as: 'owner' },
          { model: User, as: 'selectedApplicant' },
          { model: User, as: 'applicants' },
        ],
      });

      function tagsMatch(task: Task) {
        return intersection(map(task.skills, 'id'), userWantedSkillIDs).length;
      }

      return interestingTasks.sort((a, b) => tagsMatch(b) - tagsMatch(a));
    },
    getTaskOwners() {
      return User.findAll({
        attributes: ['id', 'name'],
        include: {
          model: Task, as: 'ownTasks', right: true, attributes: [],
        },
        group: ['User.id', 'User.name'],
        order: ['name'],
      });
    },
  },

  Task: {
    owner(task: Task) {
      return task.owner;
    },

    skills(task: Task) {
      return task.skills;
    },

    attachments(task: Task) {
      return task.attachments;
    },

    selectedApplicant(task: Task) {
      return task.selectedApplicant;
    },

    applicants(task: Task) {
      return task.applicants;
    },
  },
};
