import { gql } from 'apollo-server-express';

module.exports = gql`

  type Skill {
    id: Int!
    name: String!
  }

  extend type Query {
    getAllSkills: [Skill!]
  }

  extend type Mutation {
    createSkill(name: String!): Skill
  }

`;
