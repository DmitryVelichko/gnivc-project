import React from 'react';
import { render } from '@testing-library/react';
import { MemoryRouter, Route } from 'react-router-dom';

import TaskCard from '../TaskCard';
import Status from '../../../types/Status';

const testId = 'testingTaskCard';

type TaskCardProps = React.ComponentProps<typeof TaskCard>;

const renderComponent = (props: TaskCardProps = {
  task: {
    id: 1,
    owner: {
      id: 1, guid: '', name: 'Ivan', email: 'some@mail.com',
    },
    name: 'Task name',
    price: 500,
    duration: 10,
    dueDate: '2021-12-31',
    weight: 50,
    status: Status.CREATED,
  },
}) => render(
  <MemoryRouter initialEntries={['/own-tasks/1']}>
    <Route path="/own-tasks/1">
      <TaskCard
        data-testid={testId}
        {...props}
      />
    </Route>
  </MemoryRouter>,
);

describe('Компонент TaskCard', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
