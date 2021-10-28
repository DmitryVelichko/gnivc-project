import { gql } from 'apollo-server-express';

module.exports = gql`

  enum Status { created, offered, assigned, started, canceled, completed }
  enum FilterStatus { offered, assigned, started, canceled, completed }
  enum OrderCol { name, price, duration, dueDate, weight, status, views, createdAt }
  enum OrderDirection { ASC, DESC }

  type Task {
    id: Int!
    owner: User!
    selectedApplicant: User
    applicants: [User!]
    skills: [Skill!]
    attachments: [File!]
    name: String!
    description: String!
    price: Float!
    link: String
    duration: Int!
    dueDate: String!
    weight: Int!
    status: Status!
    views: Int,
    createdAt: String
  }

  extend type Query {
    getTask(id: Int!): Task
    findTasks(input: FindTasksInput!): FindResponse
    getOwnTasks: [Task]
    getParticipatedTasks: [Task]
    getInterestingTasks: [Task]
    getTaskOwners: [TaskOwner]
  }

  extend type Mutation {
    createTask(input: CreateTaskInput!): Task
    updateTask(input: UpdateTaskInput!, id: Int!): Task
    offerTask(id: Int!): Task
    unOfferTask(id: Int!): Task
    assignTask(taskId: Int!, applicantId: Int!): Task
    unAssignTask(taskId: Int!): Task
    startTask(taskId: Int!): Task
    cancelTask(taskId: Int!): Task
    completeTask(taskId: Int!): Task
    deleteTask(taskId: Int!): Boolean
  }

  input CreateTaskInput {
    skills: [Int!]
    attachments: [Upload!]
    name: String!
    description: String!
    price: Float!
    link: String
    duration: Int!
    dueDate: String!
    weight: Int!
  }

  input UpdateTaskInput {
    skills: [Int!]
    newAttachments: [Upload!]
    oldAttachments: [Int!]
    name: String
    description: String
    price: Float
    link: String
    duration: Int
    dueDate: String
    weight: Int
  }

  input FindTasksInput {
    offset: Int
    limit: Int!
    orderBy: OrderCol,
    orderDirection: OrderDirection,
    owner: Int
    priceFrom: String
    priceTo: String
    skills: [String!]
    dueDateFrom: String
    dueDateTo: String
    weightFrom: String
    weightTo: String
    status: [FilterStatus!]
  }

  type FindResponse {
    count: Int
    rows: [Task]
  }
  
  type TaskOwner {
    id: Int
    name: String
  }

`;
