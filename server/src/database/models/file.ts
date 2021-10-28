// https://github.com/RobinBuschmann/sequelize-typescript#why---model
/* eslint-disable import/no-cycle */
import {
  BelongsTo, Column, ForeignKey, Index, IsNumeric, Length, Model, Table,
} from 'sequelize-typescript';

import { CreateAttachDto } from '../DTO/create-attach.dto';
import Task from './task';

@Table
export default class File extends Model<File, CreateAttachDto> {
  @Index
  @IsNumeric
  @ForeignKey(() => Task)
  @Column
  taskId: number;

  @BelongsTo(() => Task, { onDelete: 'cascade' })
  task: Task;

  @Length({ min: 2, max: 255 })
  @Column
  filename!: string;

  @Column
  size!: number;
}
