import {
  Column, Index, Length, Model, Table,
} from 'sequelize-typescript';

import { CreateSkillDTO } from '../DTO/create-skill.dto';

@Table
export default class Skill extends Model<Skill, CreateSkillDTO> {
  @Index({ type: 'UNIQUE' })
  @Length({ min: 2, max: 255 })
  @Column
  name!: string;
}
