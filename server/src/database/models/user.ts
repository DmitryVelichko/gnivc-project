// https://github.com/RobinBuschmann/sequelize-typescript#why---model
/* eslint-disable import/no-cycle */
import {
  BelongsToMany, Column, HasMany, Index, IsEmail, Length, Model, Table,
} from 'sequelize-typescript';

import Skill from './skill';
import WantedSkills from './wantedSkills';
import LearnedSkills from './learnedSkills';
import Task from './task';
import Applicants from './applicants';

@Table
export default class User extends Model {
  @Column
  guid: string;

  @Index({ type: 'UNIQUE' })
  @Length({ min: 2, max: 255 })
  @Column
  name!: string;

  @Index({ type: 'UNIQUE' })
  @IsEmail
  @Column
  email!: string;

  @HasMany(() => Task, 'ownerId')
  ownTasks: Task[];

  @BelongsToMany(() => Task, () => Applicants)
  participatedTasks: Task[];

  @BelongsToMany(() => Skill, () => WantedSkills)
  wantedSkills?: Skill[];

  @BelongsToMany(() => Skill, () => LearnedSkills)
  learnedSkills?: Skill[];
}
