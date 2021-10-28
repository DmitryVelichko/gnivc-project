import User from '../../database/models/user';
import { checkAuthorization, checkEntityExistence } from '../../utils/premissoins';
import Skill from '../../database/models/skill';

require('dotenv').config();

module.exports = {
  Mutation: {
    async setWantedSkills(_, { skills }: { skills: number[] }, user: User = null) {
      checkAuthorization(user);
      const result = await user.$set('wantedSkills', skills);
      return result !== undefined;
    },
  },
  Query: {
    async getUserByGUID(_, { userGUID }) {
      const user = await User.findOne({
        where: { guid: userGUID },
        include: [
          { model: Skill, as: 'wantedSkills' },
          { model: Skill, as: 'learnedSkills' },
        ],
      });
      checkEntityExistence(user);
      return user;
    },
    async getUserByID(_, { ID }) {
      const user = await User.findByPk(ID, {
        include: [
          { model: Skill, as: 'wantedSkills' },
          { model: Skill, as: 'learnedSkills' },
        ],
      });
      checkEntityExistence(user);
      return user;
    },
  },

  User: {
    learnedSkills(user: User) {
      return user.learnedSkills;
    },

    wantedSkills(user: User) {
      return user.wantedSkills;
    },
  },
};
