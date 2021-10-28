// https://github.com/RobinBuschmann/sequelize-typescript#why---model
/* eslint-disable import/no-cycle */
import {
  BelongsTo, BelongsToMany, Column, DataType, ForeignKey, HasMany, Index, IsNumeric, Length, Model, NotNull, Table,
} from 'sequelize-typescript';

import User from './user';
import Applicants from './applicants';
import File from './file';
import Skill from './skill';
import TaskSkills from './taskSkills';
import { CreateTaskDTO } from '../DTO/create-task.dto';

export type Status = 'created' | 'offered' | 'assigned' | 'started' | 'canceled' | 'completed';

@Table
export default class Task extends Model<Task, CreateTaskDTO> {
  @Index
  @NotNull
  @IsNumeric
  @ForeignKey(() => User)
  @Column({ allowNull: false, comment: 'Владелец задачи' })
  ownerId: number;

  @IsNumeric
  @ForeignKey(() => User)
  @Column({ comment: 'Выбранный исполнитель' })
  selectedApplicantId: number;

  @Length({ min: 1, max: 255 })
  @Column({ comment: 'Название' })
  name!: string;

  @Column({ type: DataType.TEXT, comment: 'Подробное описание' })
  description!: string;

  @Column({ type: DataType.DECIMAL(10, 2), comment: 'Сумма премии' })
  price!: number;

  @Length({ min: 2, max: 255 })
  @Column({ comment: 'Ссылка на первоисточник' })
  link?: string;

  @Column({ comment: 'Оцененная длительность в днях' })
  duration!: number;

  @Column({ type: DataType.DATEONLY, comment: 'Дедлайн' })
  dueDate!: Date;

  @Column({ comment: 'Требуемый процент задействования исполнителя' })
  weight!: number;

  @Index
  @Column({
    type: DataType.ENUM('created', 'offered', 'assigned', 'started', 'canceled', 'completed'),
    comment: 'Текущий статус работы',
  })
  status!: Status;

  @Column({ comment: 'Число просмотров' })
  views: number;

  @BelongsTo(() => User, 'ownerId')
  owner!: User;

  @BelongsTo(() => User, 'selectedApplicantId')
  selectedApplicant?: User;

  @BelongsToMany(() => User, () => Applicants)
  applicants?: User[];

  @HasMany(() => File)
  attachments?: File[];

  @BelongsToMany(() => Skill, () => TaskSkills)
  skills?: Skill[];
}
