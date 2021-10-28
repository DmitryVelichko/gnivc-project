import { gql } from 'apollo-server-express';

module.exports = gql`

  scalar Upload

  type File {
    id: Int!
    filename: String!
    size: Int!
  }

`;
