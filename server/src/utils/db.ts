import { Op } from 'sequelize';

import Task, { Status } from '../database/models/task';
import Skill from '../database/models/skill';
import User from '../database/models/user';
import {
  checkApplicant, checkAuthorization, checkEntityExistence, checkOwner, checkStatus,
} from './premissoins';

export function getFilter(input: Record<string, unknown>, filedName: string): Record<string, unknown> {
  const from = input[`${filedName}From`];
  const to = input[`${filedName}To`];

  if (!from && !to) return {};

  if (from && !to) {
    return { [filedName]: { [Op.gte]: from } };
  }

  if (!from && to) {
    return { [filedName]: { [Op.lte]: to } };
  }

  return {
    [filedName]: {
      [Op.and]: { [Op.gte]: from, [Op.lte]: to },
    },
  };
}

export async function setSkills(input: { skills: number[] }, task: Task): Promise<void> {
  const skills = await Skill.findAll({ where: { id: { [Op.in]: input.skills } } });
  await task.$set('skills', skills);
}

export async function getTask(user: User, id: string, status: Status, checkedRelation: 'owner' | 'applicant' | '' = 'owner'): Promise<Task> {
  checkAuthorization(user);
  const task = await Task.findByPk(id);
  checkEntityExistence(task);
  checkStatus(task, status);

  if (checkedRelation === 'applicant') {
    checkApplicant(task.selectedApplicantId, user);
  }
  if (checkedRelation === 'owner') {
    checkOwner(task.ownerId, user);
  }

  return task;
}
