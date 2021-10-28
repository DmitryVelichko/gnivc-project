import React from 'react';
import { render } from '@testing-library/react';
import { MemoryRouter, Route } from 'react-router-dom';

import CreatedTasks from '../CreatedTasks';

const testId = 'testingCreatedTasks';

type CreatedTasksProps = React.ComponentProps<typeof CreatedTasks>;

const renderComponent = (props: CreatedTasksProps = {
  data: [],
  offerTask: () => {
  },
  deleteTask: () => {
  },
}) => render(
  <MemoryRouter initialEntries={['/own-tasks/1']}>
    <Route path="/own-tasks/1">
      <CreatedTasks
        data-testid={testId}
        {...props}
      />
    </Route>
  </MemoryRouter>,
);

describe('Компонент CreatedTasks', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
