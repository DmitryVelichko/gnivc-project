import express from 'express';
import { AuthenticationError } from 'apollo-server-express';

import User from '../../database/models/user';
import { verifyOnline } from '../../utils/premissoins';

const getUser = async ({ req }: { req: express.Request }) => {
  try {
    const token = req.headers?.authorization || '';
    if (!token) return null;

    const userGUID = await verifyOnline(token);
    return await User.findOne({ where: { guid: userGUID } });
  } catch (error) {
    throw new AuthenticationError(error.message);
  }
};

module.exports = getUser;
