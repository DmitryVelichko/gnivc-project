// https://github.com/RobinBuschmann/sequelize-typescript#why---model
/* eslint-disable import/no-cycle */
import {
  Column, ForeignKey, Model, Table,
} from 'sequelize-typescript';

import Skill from './skill';
import User from './user';

@Table
export default class WantedSkills extends Model {
  @ForeignKey(() => Skill)
  @Column
  skillId: number;

  @ForeignKey(() => User)
  @Column
  userId: number;
}
