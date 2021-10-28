import { Icon, Typography } from '@ff/ui-kit';
import React from 'react';
import { observer } from 'mobx-react-lite';

import homeStore from '../../../stores/homeStore/HomeStore';
import styles from './Home.module.scss';
import ErrorMessage from '../../ErrorMessage';
import TasksSkeleton from '../../TasksSkeleton';
import TaskCard from '../../TaskCard';

const Home: React.FC = observer(() => {
  const { isError, isLoading, tasks } = homeStore;

  React.useEffect(() => {
    homeStore.fetchTasks();
    return () => homeStore.clearTasks();
  }, []);

  return (
    <>
      <div className={styles.component}>
        <Typography.Title className={styles.title} level={3}>
          Рекомендуем
        </Typography.Title>

        <div className={styles.tasks}>
          {isError && (
            <ErrorMessage>
              <span>Не удалось загрузить данные</span>
              <Icon name="emoji_frown" />
            </ErrorMessage>
          )}

          {isLoading && <TasksSkeleton />}

          {!isError
            && !isLoading
            && tasks.map((task) => <TaskCard key={task.id} task={task} />)}
        </div>
      </div>
    </>
  );
});

export default Home;
