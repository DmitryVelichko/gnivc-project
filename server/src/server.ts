import http from 'http';
import { ApolloServerPluginDrainHttpServer } from 'apollo-server-core';
import path from 'path';
import express from 'express';
import { Sequelize } from 'sequelize-typescript';

const { graphqlUploadExpress } = require('graphql-upload');
const { ApolloServer } = require('apollo-server-express');
require('dotenv').config();
const cors = require('cors');
const open = require('open');

const typeDefs = require('./graphql/schemas');
const resolvers = require('./graphql/resolvers');
const context = require('./graphql/context');

const app = express();

const sequelize = new Sequelize({
  database: process.env.DB_BASE,
  dialect: 'postgres',
  host: process.env.REAL_DB ? process.env.DB_REAL_HOST : process.env.DB_HOST,
  username: process.env.DB_USER,
  password: process.env.DB_PASS,
  models: [`${__dirname}/database/models`],
});

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '../../public')));
app.use(graphqlUploadExpress());

async function startApolloServer() {
  const httpServer = http.createServer(app);
  const apolloServer = new ApolloServer({
    typeDefs,
    resolvers,
    context,
    plugins: [ApolloServerPluginDrainHttpServer({ httpServer })],
  });
  await sequelize.sync();
  await apolloServer.start();
  apolloServer.applyMiddleware({ app, path: '/api' });
  await new Promise((resolve) => {
    httpServer.listen({ port: 4000 }, (): void => resolve(true));
  });
  console.log(`Server ready at http://localhost:4000${apolloServer.graphqlPath}`);

  if (process.env.RUN_CLIENT) {
    console.log('Client ready at http://localhost:3000');
    console.log('Browser will be opened in a second...');
    open('http://localhost:3000/');
  }
}

module.exports = startApolloServer;
