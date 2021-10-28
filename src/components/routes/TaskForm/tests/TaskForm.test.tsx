import React from 'react';
import { render } from '@testing-library/react';
import { MemoryRouter, Route } from 'react-router-dom';

import AddTaskForm from '../TaskForm';

const testId = 'testingAddTaskForm';

type TaskFormProps = React.ComponentProps<typeof AddTaskForm>;

const renderComponent = (props: TaskFormProps = {}) => render(
  <MemoryRouter initialEntries={['/edit-task//1']}>
    <Route path="/edit-task/1">
      <AddTaskForm data-testid={testId} {...props} />
    </Route>
  </MemoryRouter>,
);

describe('Компонент AddTaskForm', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
