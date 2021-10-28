import {
  Column, ForeignKey, Model, Table,
} from 'sequelize-typescript';

import Skill from './skill';
import User from './user';

@Table
export default class LearnedSkills extends Model {
  @ForeignKey(() => Skill)
  @Column
  skillId: number;

  @ForeignKey(() => User)
  @Column
  userId: number;
}
