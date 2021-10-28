const { gql } = require('apollo-server-express');

const userType = require('./user');
const skillType = require('./skill');
const fileType = require('./file');
const taskType = require('./task');
const applicationType = require('./application');

const rootType = gql`
  type Query {
    root: String
  }
  type Mutation {
    root: String
  }
`;

module.exports = [rootType, userType, skillType, fileType, taskType, applicationType];
