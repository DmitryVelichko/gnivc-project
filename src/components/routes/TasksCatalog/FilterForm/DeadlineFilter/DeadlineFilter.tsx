import React from 'react';
import { observer } from 'mobx-react-lite';
import { DateRangePicker } from '@ff/ui-kit';

import TasksCatalogStore from '../../../../../stores/tasksCatalogStore/tasksCatalogStore';

const DeadlineFilter = React.memo(
  observer(() => {
    const { setFilterDates, dateFilter } = TasksCatalogStore;

    return (
      <DateRangePicker
        size="small"
        fullWidth
        value={{ start: dateFilter.start, end: dateFilter.end }}
        onChange={setFilterDates}
      />
    );
  }),
);

export default DeadlineFilter;
