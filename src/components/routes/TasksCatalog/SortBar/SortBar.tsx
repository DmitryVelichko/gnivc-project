import { Button, ButtonGroup, icons } from '@ff/ui-kit';
import React from 'react';
import { get } from 'lodash';

import styles from './SortBar.module.scss';
import TasksCatalogStore from '../../../../stores/tasksCatalogStore/tasksCatalogStore';

const SortBar: React.FC = () => {
  const { sort, filter } = TasksCatalogStore;

  const columns = {
    name: 'Название',
    price: 'Премия',
    duration: 'Длительность',
    dueDate: 'Дедлайн',
    weight: 'Процент задействования',
    status: 'Статус',
    views: 'Просмотры',
    createdAt: 'Дата создания',
  };

  function getEndIcon(col: string) {
    if (filter.orderBy !== col) return '';
    return filter.orderDirection === 'ASC' ? icons.sortDownAlt : icons.sortUp;
  }

  return (
    <div className={styles.component}>
      <ButtonGroup fullWidth variant="outline">
        {Object.keys(columns).map((key) => (
          <Button
            key={key}
            className={styles.sortButton}
            endIcon={getEndIcon(key)}
            onClick={() => sort(key)}
          >
            {get(columns, key)}
          </Button>
        ))}
      </ButtonGroup>
    </div>
  );
};

export default SortBar;
