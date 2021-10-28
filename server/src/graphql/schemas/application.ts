import { gql } from 'apollo-server-express';

module.exports = gql`

  extend type Mutation {
    submitApplication(taskId: Int!): Boolean
    revokeApplication(taskId: Int!): Boolean
  }

`;
