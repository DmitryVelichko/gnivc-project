import {
  Button, Icon, icons, Modal,
} from '@ff/ui-kit';
import React from 'react';
import { Link } from 'react-router-dom';

import styles from './CreatedTasks.module.scss';
import { Task } from '../../../../types/Task';
import TaskCard from '../../../TaskCard';

type CreatedTasksProps = {
  data: Task[];
  offerTask: (id: number) => void;
  deleteTask: (id: number) => void;
};

const CreatedTasks: React.FC<CreatedTasksProps> = ({
  data,
  offerTask,
  deleteTask,
}) => {
  const [modal, setModal] = React.useState<{
    isOpen: boolean;
    id: number;
    label: 'предложить' | 'удалить';
  }>({ isOpen: false, id: 0, label: 'предложить' });

  const closeModalHandler = () => {
    setModal((prev) => ({ ...prev, isOpen: false }));
  };

  const doActionHandler = () => {
    if (modal.label === 'предложить') {
      offerTask(modal.id);
    } else if (modal.label === 'удалить') {
      deleteTask(modal.id);
    }
  };

  return (
    <>
      {data.map((task) => (
        <div key={task.id} className={styles.component}>
          <TaskCard created task={task} />

          <div className={styles.buttons}>
            <button
              type="button"
              onClick={() => setModal({ isOpen: true, id: task.id, label: 'предложить' })}
            >
              <Icon name={icons.bell} />
              Предложить
            </button>

            <Link to={`/edit-task/${task.id}`}>
              <Icon name={icons.PencilSquare} />
              Редактировать
            </Link>

            <button
              type="button"
              onClick={() => setModal({ isOpen: true, id: task.id, label: 'удалить' })}
            >
              <Icon name={icons.delete} />
              Удалить
            </button>
          </div>
        </div>
      ))}

      <Modal
        anchor="root"
        title={`Вы уверены, что хотите ${modal.label} задачу?`}
        visible={modal.isOpen}
        onClose={closeModalHandler}
      >
        <div className={styles.modal}>
          <Button
            type={modal.label === 'удалить' ? 'danger' : 'primary'}
            onClick={doActionHandler}
          >
            Да
          </Button>
          <Button onClick={closeModalHandler}>Отмена</Button>
        </div>
      </Modal>
    </>
  );
};

export default CreatedTasks;
