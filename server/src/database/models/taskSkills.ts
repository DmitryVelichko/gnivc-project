// https://github.com/RobinBuschmann/sequelize-typescript#why---model
/* eslint-disable import/no-cycle */
import {
  Column, ForeignKey, Model, Table,
} from 'sequelize-typescript';

import Task from './task';
import Skill from './skill';

@Table
export default class TaskSkills extends Model {
  @ForeignKey(() => Skill)
  @Column
  skillId: number;

  @ForeignKey(() => Task)
  @Column
  taskId: number;
}
