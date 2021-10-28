import React from 'react';
import { Link } from 'react-router-dom';
import { Icon, icons, Tag } from '@ff/ui-kit';
import { observer } from 'mobx-react-lite';

import styles from './TaskCard.module.scss';
import { formatDateToRU, formatNumber, pluralize } from '../../utils';
import { TagType } from '../../types/Tag';
import { Task } from '../../types/Task';

type TasksProps = {
  task: Task;
  created?: boolean;
};

function drawWeightBar(weight: number) {
  const discreteWeight = Math.ceil(weight / 25) * 25;
  const weightClass = styles[`weight${discreteWeight}`];
  return (
    <div
      className={styles.progress}
      title={`Процент задействования исполнителя: ${weight}%`}
    >
      <div
        className={`${styles.progressBar} ${weightClass}`}
        style={{ width: `${weight}%` }}
      />
    </div>
  );
}

function getStatusTag(item: Task) {
  const statusNames: { [key: string]: string } = {
    offered: 'Предложена',
    assigned: 'Назначена',
    started: 'Начата',
    canceled: 'Отменена',
    completed: 'Завершена',
  };
  const statusClasses: { [key: string]: TagType } = {
    offered: 'success',
    assigned: 'warning',
    started: 'primary',
    canceled: 'outline',
    completed: 'info',
  };
  return (
    <Tag
      label={statusNames[item.status]}
      className={`${styles.tag}`}
      type={statusClasses[item.status]}
    />
  );
}

const TaskCard: React.FC<TasksProps> = observer(
  ({ task, created = false }: TasksProps) => (
    <Link
      target="_blank"
      to={`/tasks/${task.id}`}
      key={task.id}
      className={`${styles.card}`}
    >
      <div>
        <header>
          <h1>{task.name}</h1>
        </header>
        <div className={styles.params}>
          {!created && (
            <div className={styles.paramsBlock} title="Количество просмотров">
              <Icon className={styles.paramsIcon} name={icons.eye} />
              <strong>{task.views}</strong>
            </div>
          )}
          {task.applicants && !created && (
            <div className={styles.paramsBlock} title="Количество откликов">
              <Icon className={styles.paramsIcon} name={icons.chatDots} />
              <strong>{task.applicants.length}</strong>
            </div>
          )}
          {!created && (
            <div className={styles.paramsBlock} title="Владелец задачи">
              <Icon className={styles.paramsIcon} name={icons.pencilSquare} />
              <span>{task.owner.name}</span>
            </div>
          )}
          {task.selectedApplicant && !created && (
            <div className={styles.paramsBlock} title="Исполнитель задачи">
              <Icon className={styles.paramsIcon} name={icons.personCircle} />
              <span>{task.selectedApplicant.name}</span>
            </div>
          )}
        </div>
        <footer>
          {!created && getStatusTag(task)}
          {task.skills
            && task.skills.map((skill) => (
              <Tag key={skill.id} label={skill.name} className={styles.tag} />
            ))}
        </footer>
      </div>
      <div className={styles.info}>
        <div className={styles.infoBlock} title="Вознаграждение">
          <Icon name={icons.creditCard2Back} className={styles.infoIcon} />
          {formatNumber(task.price)} руб.
        </div>
        <div className={styles.infoBlock} title="Крайний срок">
          <Icon name={icons.clock} className={styles.infoIcon} />
          {formatDateToRU(task.dueDate)}
        </div>
        <div className={styles.infoBlock} title="Длительность">
          <Icon name={icons.calendar3} className={styles.infoIcon} />
          {task.duration} {pluralize(+task.duration, ['день', 'дня', 'дней'])}
        </div>
        <div className={styles.infoBlock}>{drawWeightBar(task.weight)}</div>
      </div>
    </Link>
  ),
);

export default TaskCard;
