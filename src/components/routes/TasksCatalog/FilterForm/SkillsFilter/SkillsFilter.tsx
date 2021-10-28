import React from 'react';
import { observer } from 'mobx-react-lite';
import { Select } from '@ff/ui-kit';

import TasksCatalogStore from '../../../../../stores/tasksCatalogStore/tasksCatalogStore';
import styles from '../FilterForm.module.scss';
import SkillStore from '../../../../../stores/skillStore/skillStore';

const SkillsFilter = React.memo(
  observer(() => {
    const { filterSkills, setFilterSkills } = TasksCatalogStore;
    const { skills } = SkillStore;

    return (
      <Select
        options={skills}
        placeholder="Выберите значение из списка"
        showSearch
        multiple
        value={filterSkills || []}
        onChange={(newSkills) => Array.isArray(newSkills) && setFilterSkills(newSkills)}
        className={`${styles.label}`}
      />
    );
  }),
);

export default SkillsFilter;
