import React from 'react';
import { observer } from 'mobx-react-lite';
import { Select } from '@ff/ui-kit';

import TasksCatalogStore from '../../../../../stores/tasksCatalogStore/tasksCatalogStore';
import styles from '../FilterForm.module.scss';

const OwnerFilter = React.memo(observer(() => {
  const { owners, filterOwner, setFilterOwner } = TasksCatalogStore;

  return (
    <Select
      placeholder="Иван Иванов"
      options={owners}
      showSearch
      value={(filterOwner?.toString()) || ''}
      onChange={(owner) => typeof owner === 'string' && setFilterOwner(+owner)}
      className={`${styles.label}`}
    />
  );
}));

export default OwnerFilter;
