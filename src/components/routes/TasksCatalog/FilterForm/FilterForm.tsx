import {
  Button, Col, Select, TextField,
} from '@ff/ui-kit';
import React, { FC } from 'react';
import { observer } from 'mobx-react-lite';

import styles from './FilterForm.module.scss';
import TasksCatalogStore from '../../../../stores/tasksCatalogStore/tasksCatalogStore';
import DeadlineFilter from './DeadlineFilter';
import OwnerFilter from './OwnerFilter';
import SkillsFilter from './SkillsFilter';

const FilterForm: FC = observer(() => {
  const {
    setSearch, setPage, patchFilter, filter, fetchTasks, resetFilter,
  } = TasksCatalogStore;

  const statuses = [
    { key: 2, value: 'offered', label: 'Предложена' },
    { key: 3, value: 'assigned', label: 'Назначена' },
    { key: 4, value: 'started', label: 'Начата' },
    { key: 5, value: 'canceled', label: 'Отменена' },
    { key: 6, value: 'completed', label: 'Завершена' },
  ];

  const applyHandler = () => {
    setPage(1);
    fetchTasks();
  };

  return (
    <Col xs="4">
      <div className={styles.component}>
        <TextField
          startAdornment="search"
          placeholder="Поиск по названию"
          onChange={setSearch}
        />

        <div>
          <h3>Владелец</h3>
          <OwnerFilter />
        </div>

        <div>
          <h3>Премия</h3>
          <div className={styles.range}>
            <TextField
              placeholder="от 500 руб."
              type="number"
              value={filter.priceFrom || ''}
              onChange={(event) => patchFilter({ priceFrom: event.target.value })}
            />
            <TextField
              placeholder="до 100 000 руб"
              type="number"
              value={filter.priceTo || ''}
              onChange={(event) => patchFilter({ priceTo: event.target.value })}
            />
          </div>
        </div>

        <div>
          <h3>Технологии</h3>
          <SkillsFilter />
        </div>

        <div>
          <h3 className={styles.mbFix}>Дедлайн</h3>
          <DeadlineFilter />
        </div>

        <div>
          <h3>Процент задействования</h3>
          <div className={styles.range}>
            <TextField
              placeholder="от 0%"
              type="number"
              value={filter.weightFrom || ''}
              onChange={(event) => patchFilter({ weightFrom: event.target.value })}
            />
            <TextField
              placeholder="до 100%"
              type="number"
              value={filter.weightTo || ''}
              onChange={(event) => patchFilter({ weightTo: event.target.value })}
            />
          </div>
        </div>

        <div>
          <h3>Статус</h3>
          <Select
            options={statuses}
            placeholder="Выберите значение из списка"
            showSearch
            multiple
            value={filter?.status || []}
            onChange={(status) => Array.isArray(status) && patchFilter({ status })}
            className={`${styles.label}`}
          />
        </div>
        <div className={styles.buttons}>
          <Button onClick={applyHandler} type="primary">
            Применить
          </Button>
          <Button onClick={() => resetFilter()}>Сбросить</Button>
        </div>
      </div>
    </Col>
  );
});

export default FilterForm;
