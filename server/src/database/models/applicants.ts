// https://github.com/RobinBuschmann/sequelize-typescript#why---model
/* eslint-disable import/no-cycle */
import {
  Column, ForeignKey, Model, Table,
} from 'sequelize-typescript';

import User from './user';
import Task from './task';

@Table
export default class Applicants extends Model {
  @ForeignKey(() => User)
  @Column
  userId: number;

  @ForeignKey(() => Task)
  @Column
  taskId: number;
}
