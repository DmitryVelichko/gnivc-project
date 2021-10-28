const userResolvers = require('./user');
const skillResolvers = require('./skill');
const taskResolvers = require('./task');
const applicationResolvers = require('./application');

module.exports = [userResolvers, skillResolvers, taskResolvers, applicationResolvers];
