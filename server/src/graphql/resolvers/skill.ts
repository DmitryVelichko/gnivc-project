import { checkAuthorization } from '../../utils/premissoins';
import Skill from '../../database/models/skill';
import User from '../../database/models/user';

module.exports = {
  Mutation: {
    createSkill(_, { name }: { name: string }, user: User = null) {
      checkAuthorization(user);
      return Skill.create({ name });
    },
  },

  Query: {
    async getAllSkills() {
      return Skill.findAll();
    },
  },
};
