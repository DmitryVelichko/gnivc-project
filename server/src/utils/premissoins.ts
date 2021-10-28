import {
  AuthenticationError,
  ForbiddenError,
  ValidationError,
} from 'apollo-server-express';
import { Model } from 'sequelize-typescript';
import axios from 'axios';

import User from '../database/models/user';
import Task, { Status } from '../database/models/task';

require('dotenv').config();

export function checkAuthorization(user: User): void {
  if (!user.id) {
    throw new AuthenticationError('You must login to perform this operation');
  }
}

export function checkOwner(ownerId: number, user: User): void {
  if (ownerId !== user.id) {
    throw new ForbiddenError('You have no rights for this operation');
  }
}

export function checkApplicant(applicantId: number, user: User): void {
  if (applicantId !== user.id) {
    throw new ForbiddenError(
      'Selected applicant only, can perform this operation'
    );
  }
}

export function checkStatus(task: Task, status: Status): void {
  if (task.status !== status) {
    throw new ForbiddenError(
      'This operation cannot be performed on this stage of task lifecycle'
    );
  }
}

export function checkEntityExistence(entity: Model): void {
  if (!entity) {
    throw new ValidationError('Requested subject not found');
  }
}

export function verifyOnline(accessToken: string): Promise<string> {
  const keycloakHost = process.env.REAL_KEYCLOAK
    ? process.env.KEYCLOAK_REAL_HOST
    : process.env.KEYCLOAK_HOST;
  return axios
    .get(
      `${keycloakHost}/auth/realms/${process.env.KEYCLOAK_REALM}/protocol/openid-connect/userinfo`,
      { headers: { Authorization: `Bearer ${accessToken}` } }
    )
    .then((response) => response.data.sub);
}
