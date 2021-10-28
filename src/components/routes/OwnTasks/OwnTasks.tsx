import {
  Icon, Tab, TabPanel, TabPanels, Tabs, Typography,
} from '@ff/ui-kit';
import { observer } from 'mobx-react-lite';
import React from 'react';
import { Link, useHistory, useParams } from 'react-router-dom';

import TaskService from '../../../services/taskService/taskService';
import OwnTasksStore from '../../../stores/ownTasksStore/ownTasksStore';
import TasksSkeleton from '../../TasksSkeleton';
import CreatedTasks from './CreatedTasks';
import styles from './OwnTasks.module.scss';
import TaskCard from '../../TaskCard';
import ErrorMessage from '../../ErrorMessage';
import AppStore from '../../../stores/appStore/AppStore';

type RouteParams = {
  tab: string;
};

const OwnTasks: React.FC = observer(() => {
  const {
    isError, isLoading, currentTasks, finishedTasks, draftTasks,
  } = OwnTasksStore;

  const { tab } = useParams<RouteParams>();

  React.useEffect(() => {
    OwnTasksStore.fetchTasks();
    return () => OwnTasksStore.clearTasks();
  }, []);

  const [currentTab, setCurrentTab] = React.useState<number | string>('1');
  const history = useHistory();

  React.useEffect(() => {
    setCurrentTab(tab || '1');
  }, [tab]);

  const changeTabHandler = (value: string | number) => {
    if (value !== currentTab) {
      history.push(`/own-tasks/${value}`);
    }
  };

  const EmptyMessage = ({
    link = null,
  }: {
    link?: React.ReactElement | null;
  }) => (
    <ErrorMessage>
      <span>Задач не найдено </span>
      <Icon name="emoji_neutral" />
      {link}
    </ErrorMessage>
  );

  const offerTaskHandler = async (id: number) => {
    try {
      await TaskService.offerTask(id); // todo: перенести в store
      await OwnTasksStore.fetchTasks();
    } catch {
      AppStore.setError();
    }
  };
  const deleteTaskHandler = async (id: number) => {
    try {
      await TaskService.deleteTask(id); // todo: перенести в store
      await OwnTasksStore.fetchTasks();
    } catch {
      AppStore.setError();
    }
  };

  const toDraftHandler = () => {
    setCurrentTab('3');
  };

  return (
    <div className={styles.component}>
      <Typography.Title className={styles.title} level={3}>
        Мои задачи
      </Typography.Title>
      <Tabs
        className={styles.tabs}
        value={currentTab}
        onChange={changeTabHandler}
      >
        <Tab value="1">Текущие</Tab>
        <Tab value="2">Завершенные</Tab>
        <Tab value="3">Непредложенные</Tab>
      </Tabs>
      <div className={styles.tasks}>
        {OwnTasksStore.isError && (
          <ErrorMessage>
            <span>Не удалось загрузить данные</span>
            <Icon name="emoji_frown" />
          </ErrorMessage>
        )}

        {isLoading && <TasksSkeleton />}

        {!isError && !isLoading && (
          <TabPanels value={currentTab}>
            <TabPanel value="1">
              <div className={styles.count}>
                Найденное количество задач: {currentTasks.length}
              </div>
              {currentTasks.length ? (
                currentTasks.map((task) => (
                  <TaskCard key={task.id} task={task} />
                ))
              ) : (
                <EmptyMessage
                  link={(
                    <button type="button" onClick={toDraftHandler}>
                      Предложить задачу
                    </button>
                  )}
                />
              )}
            </TabPanel>

            <TabPanel value="2">
              <div className={styles.count}>
                Найденное количество задач: {finishedTasks.length}
              </div>
              {finishedTasks.length ? (
                finishedTasks.map((task) => (
                  <TaskCard key={task.id} task={task} />
                ))
              ) : (
                <EmptyMessage />
              )}
            </TabPanel>

            <TabPanel value="3">
              <div className={styles.count}>
                Найденное количество задач: {draftTasks.length}
              </div>
              {draftTasks.length ? (
                <CreatedTasks
                  offerTask={offerTaskHandler}
                  deleteTask={deleteTaskHandler}
                  data={draftTasks}
                />
              ) : (
                <EmptyMessage
                  link={<Link to="/add-task">Добавить задачу</Link>}
                />
              )}
            </TabPanel>
          </TabPanels>
        )}
      </div>
    </div>
  );
});

export default OwnTasks;
