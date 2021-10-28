import { gql } from 'apollo-server-express';

module.exports = gql`
  type User {
    id: Int!
    guid: String
    name: String!
    email: String!
    learnedSkills: [Skill!]
    wantedSkills: [Skill!]
  }

  extend type Query {
    getUserByGUID(userGUID: String!): User
    getUserByID(ID: Int!): User
  }

  extend type Mutation {
    setWantedSkills(skills: [Int!]): Boolean
  }
`;
