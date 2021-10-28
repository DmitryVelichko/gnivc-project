import {
  Accordion,
  AccordionPanel,
  Button,
  Icon,
  Modal,
  Tag,
  Typography,
} from '@ff/ui-kit';
import React from 'react';
import { Link, useParams } from 'react-router-dom';
import { useKeycloak } from '@react-keycloak/web';
import { observer } from 'mobx-react-lite';

import styles from './TaskContent.module.scss';
import TaskService from '../../../services/taskService/taskService';
import { formatDateToRU, pluralize } from '../../../utils';
import Status from '../../../types/Status';
import taskContentStore from '../../../stores/taskContentStore/taskContentStore';
import { Skill } from '../../../types/Skill';
import ErrorMessage from '../../ErrorMessage';
import AppStore from '../../../stores/appStore/AppStore';

type RouteParams = {
  id: string;
};

type TagType =
  | 'warning'
  | 'primary'
  | 'danger'
  | 'success'
  | 'default'
  | 'info'
  | 'outline'
  | 'stealth'
  | 'dark';

const statusNames: { [key: string]: string } = {
  created: 'Создана',
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

const TaskContent: React.FC = observer(() => {
  const { id: taskId } = useParams<RouteParams>();

  const { keycloak } = useKeycloak();

  const {
    task,
    isError,
    isLoading,
    userIsOwner,
    userIsApplicant,
    userIsSelectedApplicant,
  } = taskContentStore;

  React.useEffect(() => {
    taskContentStore.fetchTask(Number(taskId), keycloak.tokenParsed?.sub || '');
  }, [keycloak.tokenParsed?.sub, taskId]);

  type Modal = {
    isOpen: boolean;
    applicantId?: number | null;
    title: string;
    doAction: () => void;
  };

  const [modal, setModal] = React.useState<Modal>({
    isOpen: false,
    title: '',
    doAction: () => {},
  });

  const closeModalHandler = () => setModal((prev) => ({ ...prev, isOpen: false }));

  const doActionModalHandler = async () => {
    try {
      await modal.doAction();
    } catch {
      AppStore.setError();
    }
    setModal({
      isOpen: false,
      title: '',
      doAction: () => {},
    });
    await taskContentStore.fetchTask(
      Number(taskId),
      taskContentStore.userToken,
    );
  };

  const submitApplicationHandler = async () => {
    try {
      await TaskService.submitApplication(Number(taskId)); // todo: перенести в store
      await taskContentStore.fetchTask(
        Number(taskId),
        taskContentStore.userToken,
      );
    } catch {
      AppStore.setError();
    }
  };

  const revokeApplicationHandler = async () => {
    try {
      await TaskService.revokeApplication(Number(taskId)); // todo: перенести в store
      await taskContentStore.fetchTask(
        Number(taskId),
        taskContentStore.userToken,
      );
    } catch {
      AppStore.setError();
    }
  };

  const assignTaskHandler = (applicantId: number) => {
    setModal({
      applicantId,
      isOpen: true,
      title: 'Вы уверены, что хотите назначить данного исполнителя?',
      doAction: async () => {
        await TaskService.assignTask(Number(taskId), applicantId); // todo: перенести в store
      },
    });
  };

  const startTaskHandler = () => {
    setModal({
      isOpen: true,
      title: 'Вы уверены, что хотите начать выполнение задачи?',
      doAction: async () => {
        await TaskService.startTask(Number(taskId)); // todo: перенести в store
      },
    });
  };

  const completeTaskHandler = () => {
    setModal({
      isOpen: true,
      title: 'Вы уверены, что хотите завершить выполнение задачи?',
      doAction: async () => {
        await TaskService.completeTask(Number(taskId)); // todo: перенести в store
      },
    });
  };

  const cancelTaskHandler = () => {
    setModal({
      isOpen: true,
      title: 'Вы уверены, что хотите отменить выполнение задачи?',
      doAction: async () => {
        await TaskService.cancelTask(Number(taskId)); // todo: перенести в store
      },
    });
  };

  return (
    <div className={styles.component}>
      {isError && (
        <ErrorMessage>
          <span>Не удалось загрузить данные</span>
          <Icon name="emoji_frown" />
        </ErrorMessage>
      )}
      {isLoading && <div>Загрузка...</div>}
      {!isLoading && !isError && task !== null && (
        <>
          <div className={styles.title}>
            <Typography.Title level={3}>{task.name} </Typography.Title>
            <Tag
              label={statusNames[task.status]}
              type={statusClasses[task.status]}
            />
            <div className={styles.views}>
              <Icon name="eye" fontSize={14} />
              <span>{task.views}</span>
            </div>
          </div>

          <div className={styles.price}>
            <Icon name="credit_card_2-back" fontSize={18} />
            <span>{task.price} руб</span>
          </div>

          <Link to={`/profile/${task.owner.id}`} className={styles.owner}>
            {task.owner.name}
          </Link>
          {task.skills && (
            <div className={styles.skills}>
              {task.skills.map((skill: Skill) => (
                <Tag key={skill.id} label={skill.name} />
              ))}
            </div>
          )}
          <div className={styles.duration}>
            Оцененная длительность: {task.duration}{' '}
            {pluralize(+task.duration, ['день', 'дня', 'дней'])}
          </div>
          <div className={styles.dueDate}>
            Дедлайн: {formatDateToRU(task.dueDate)}
          </div>
          <div className={styles.weight}>
            Требуемый процент задействования исполнителя: {task.weight}%{' '}
            <span />
          </div>
          <div className={styles.link}>
            <span>Ссылка: </span>
            <a href="#">{task.link}</a>
          </div>
          <div className={styles.description}>{task.description}</div>
          {task.attachments && (
            <div className={styles.attachments}>
              <span> Файлы: </span>
              {task.attachments?.map((file) => (
                <Link
                  key={file.id}
                  to={`/uploads/${task.id}/${file.filename}`}
                  target="_blank"
                  download
                >
                  {file.filename}
                </Link>
              ))}
            </div>
          )}
          {task.selectedApplicant && (
            <div className={styles.selectedApplicant}>
              <span>Выбранный исполнитель: </span>
              <Link to={`/profile/${task.selectedApplicant.id}`}>
                {task.selectedApplicant.name}
              </Link>
            </div>
          )}
          {task.applicants && (
            <Accordion>
              <AccordionPanel
                className={styles.applicants}
                header="Cписок претендентов-исполнителей:"
              >
                {task.applicants.map((applicant) => (
                  <div className={styles.applicant} key={applicant.id}>
                    <Link to={`/profile/${applicant.id}`}>
                      {applicant.name}
                    </Link>

                    {task.status === Status.OFFERED && userIsOwner && (
                      <button
                        type="button"
                        onClick={() => assignTaskHandler(applicant.id)}
                      >
                        <Icon name="clipboard_check" fontSize={16} />
                        назначить
                      </button>
                    )}
                  </div>
                ))}
              </AccordionPanel>
            </Accordion>
          )}

          <Modal
            anchor="root"
            title={modal.title}
            visible={modal.isOpen}
            onClose={closeModalHandler}
          >
            <div className={styles.modal}>
              <Button type="primary" onClick={doActionModalHandler}>
                Да
              </Button>
              <Button onClick={closeModalHandler}>Отмена</Button>
            </div>
          </Modal>

          {task.status === Status.OFFERED && !userIsOwner && !userIsApplicant && (
            <Button
              className={styles.button}
              type="primary"
              variant="outline"
              onClick={submitApplicationHandler}
            >
              Хочу это сделать
            </Button>
          )}
          {task.status === Status.OFFERED && !userIsOwner && userIsApplicant && (
            <Button
              className={styles.button}
              type="danger"
              variant="outline"
              onClick={revokeApplicationHandler}
            >
              Отмена
            </Button>
          )}
          {task.status === Status.ASSIGNED
            && !userIsOwner
            && userIsSelectedApplicant && (
              <Button
                className={styles.button}
                type="primary"
                variant="fill"
                onClick={startTaskHandler}
              >
                Начать
              </Button>
          )}
          {task.status === Status.STARTED && userIsOwner && (
            <Button
              className={styles.button}
              type="primary"
              variant="fill"
              onClick={completeTaskHandler}
            >
              Завершить
            </Button>
          )}
          {task.status === Status.STARTED
            && !userIsOwner
            && userIsSelectedApplicant && (
              <Button
                className={styles.button}
                type="danger"
                variant="fill"
                onClick={cancelTaskHandler}
              >
                Отменить
              </Button>
          )}
        </>
      )}
    </div>
  );
});

export default TaskContent;
