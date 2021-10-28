import User from '../../database/models/user';
import { getTask } from '../../utils/db';

module.exports = {
  Mutation: {
    async submitApplication(_, { taskId }: { taskId: string }, user: User = null) {
      const task = await getTask(user, taskId, 'offered', '');
      const result = await task.$add('applicants', user.id);
      return result !== undefined;
    },

    async revokeApplication(_, { taskId }: { taskId: string }, user: User = null) {
      const task = await getTask(user, taskId, 'offered', '');
      return task.$remove('applicants', user.id);
    },
  },
};
