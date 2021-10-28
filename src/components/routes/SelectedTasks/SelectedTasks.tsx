import {
  Icon, Tab, TabPanel, TabPanels, Tabs, Typography,
} from '@ff/ui-kit';
import { observer } from 'mobx-react-lite';
import React from 'react';
import { Link, useHistory, useParams } from 'react-router-dom';

import SelectedTasksStore from '../../../stores/selectedTasksStore/SelectedTasksStore';
import ErrorMessage from '../../ErrorMessage';
import TaskCard from '../../TaskCard';
import TasksSkeleton from '../../TasksSkeleton';
import styles from './SelectedTasks.module.scss';

type RouteParams = {
  tab: string;
};

const SelectedTasks: React.FC = observer(() => {
  const {
    isError, isLoading, currentTasks, finishedTasks,
  } = SelectedTasksStore;

  const { tab } = useParams<RouteParams>();

  React.useEffect(() => {
    SelectedTasksStore.fetchTasks();
    return () => SelectedTasksStore.clearTasks();
  }, []);

  const [currentTab, setCurrentTab] = React.useState<number | string>('1');
  const history = useHistory();

  React.useEffect(() => {
    setCurrentTab(tab || '1');
  }, [tab]);

  const changeTabHandler = (value: string | number) => {
    if (value !== currentTab) {
      history.push(`/selected-tasks/${value}`);
    }
  };

  return (
    <>
      <div className={styles.component}>
        <Typography.Title className={styles.title} level={3}>
          Выбранные задачи
        </Typography.Title>
        <Tabs
          className={styles.tabs}
          value={currentTab}
          onChange={changeTabHandler}
        >
          <Tab value="1">Текущие</Tab>
          <Tab value="2">Завершенные</Tab>
        </Tabs>
        <div className={styles.tasks}>
          {isError && (
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
                  <ErrorMessage>
                    <span>Задач не найдено </span>
                    <Icon name="emoji_neutral" />
                    <Link to="/tasks">Найти задачу</Link>
                  </ErrorMessage>
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
                  <ErrorMessage>
                    <span>Задач не найдено </span>
                    <Icon name="emoji_neutral" />
                    <Link to="/tasks">Найти задачу</Link>
                  </ErrorMessage>
                )}
              </TabPanel>
            </TabPanels>
          )}
        </div>
      </div>
    </>
  );
});

export default SelectedTasks;
