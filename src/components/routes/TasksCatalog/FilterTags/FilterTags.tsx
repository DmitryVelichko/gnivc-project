import React from 'react';
import { Tag } from '@ff/ui-kit';
import { observer } from 'mobx-react-lite';
import { get, toPairs } from 'lodash';

import styles from './FilterTags.module.scss';
import TasksCatalogStore from '../../../../stores/tasksCatalogStore/tasksCatalogStore';
import SkillStore from '../../../../stores/skillStore/skillStore';
import { formatNumber } from '../../../../utils';

const FilterTags: React.FC = observer(() => {
  const { filter, omitFilter, owners } = TasksCatalogStore;
  const { skills } = SkillStore;

  function formatTitle(key: string) {
    switch (key) {
      case 'owner':
        return 'Владелец задачи';
      case 'priceFrom':
        return 'Премия от';
      case 'priceTo':
        return 'Премия до';
      case 'skills':
        return 'Технологии';
      case 'dueDateTo':
        return 'Дедлайн с';
      case 'dueDateFrom':
        return 'Дедлайн по';
      case 'weightFrom':
        return 'Занятость от';
      case 'weightTo':
        return 'Занятость до';
      case 'status':
        return 'Статус';
      default:
        return key;
    }
  }

  function formatValue(key: string, value: unknown): string {
    const statuses = {
      offered: 'Предложена',
      assigned: 'Назначена',
      started: 'Начата',
      canceled: 'Отменена',
      completed: 'Завершена',
    };
    switch (key) {
      case 'owner':
        if (typeof value === 'number') {
          const owner = owners.find((option) => option.key === value);
          return owner ? owner.label : '';
        }
        return '';
      case 'priceFrom':
      case 'priceTo':
        return typeof value === 'string' ? `${formatNumber(+value)} р.` : '';
      case 'skills':
        if (Array.isArray(value)) {
          return value
            .map((val) => skills.find((skill) => skill.key === +val)?.label)
            .join(', ');
        }
        return '';
      case 'dueDateFrom':
      case 'dueDateTo':
        return typeof value === 'string'
          ? new Date(value).toLocaleDateString()
          : '';
      case 'weightFrom':
      case 'weightTo':
        return typeof value === 'string' ? `${value} %` : '';
      case 'status':
        if (Array.isArray(value)) {
          return value.map((val) => get(statuses, val)).join(', ');
        }
        return '';
      default:
        return JSON.stringify(value);
    }
  }

  function getTag(key: string, val: unknown) {
    return (
      <Tag
        key={key}
        label={`${formatTitle(key)}: ${formatValue(key, val)}`}
        onClose={() => omitFilter(key)}
      />
    );
  }

  return (
    <div className={styles.component}>
      {toPairs(filter)
        .filter(([key, val]) => {
          const notEmpty = Array.isArray(val) ? val.length : !!val;
          return key !== 'dateFilter' && !key.startsWith('order') && notEmpty;
        })
        .map(([key, val]) => getTag(key, val))}
    </div>
  );
});

export default FilterTags;
