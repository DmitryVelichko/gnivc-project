import React from 'react';
import {
  Col, Icon, Pagination, Row, Typography,
} from '@ff/ui-kit';
import { observer } from 'mobx-react-lite';
import { useHistory, useLocation } from 'react-router-dom';

import styles from './TasksCatalog.module.scss';
import FilterForm from './FilterForm';
import TasksSkeleton from '../../TasksSkeleton';
import TasksCatalogStore from '../../../stores/tasksCatalogStore/tasksCatalogStore';
import FilterTags from './FilterTags';
import SortBar from './SortBar';
import TaskCard from '../../TaskCard';

const TasksCatalog: React.FC = observer(() => {
  const {
    tasksPerList,
    page,
    fetchTasks,
    setPage,
    clearTasks,
    count,
    isLoading,
    tasks,
    isError,
    search,
  } = TasksCatalogStore;

  const location = useLocation();
  React.useEffect(() => {
    const searchParams = new URLSearchParams(location.search);

    const pageSearch = searchParams.get('page');
    if (page !== Number(pageSearch)) {
      setPage(Number(pageSearch) || 1);
      fetchTasks();
    }
  }, [fetchTasks, location, page, setPage]);

  React.useEffect(
    () => () => {
      clearTasks();
    },
    [clearTasks],
  );

  const history = useHistory();
  const changePageHandler = (newPage: number) => {
    history.push({
      pathname: '/tasks',
      search: `?page=${newPage}`,
    });
  };

  return (
    <div id="tasksCatalog">
      <header>
        <Typography.Title level={3} className={styles.title}>
          Список задач
        </Typography.Title>
        <FilterTags />
        <SortBar />
      </header>

      <Row colGap="lg">
        <Col xs="8">
          {isError && (
            <div className={styles.message}>
              <span>Не удалось загрузить данные</span>
              <Icon name="emoji_frown" />
            </div>
          )}

          {isLoading && <TasksSkeleton />}

          {!isError && !isLoading && !tasks.length && (
            <div className={styles.message}>
              <span>Задач не найдено</span>
              <Icon name="emoji_neutral" />
            </div>
          )}

          {!isError
            && !isLoading
            && tasks.length
            && tasks
              .filter((task) => task.name.toLowerCase().includes(search.toLowerCase()))
              .map((task) => <TaskCard key={task.id} task={task} />)}

          <Row justify="center">
            {!search && count > 0 && (
              <Pagination
                size="small"
                itemCount={count}
                perPage={tasksPerList}
                currentPage={page}
                onChangeCurrentPage={changePageHandler}
              />
            )}
          </Row>
        </Col>

        <FilterForm />
      </Row>
    </div>
  );
});

export default TasksCatalog;
