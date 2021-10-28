import React from 'react';
import { render } from '@testing-library/react';
import { MemoryRouter, Route } from 'react-router-dom';

import SelectedTasks from '../SelectedTasks';

const testId = 'testingSelectedTasks';

type SelectedTasksProps = React.ComponentProps<typeof SelectedTasks>;

const renderComponent = (props: SelectedTasksProps = {}) => render(
  <MemoryRouter initialEntries={['/selected-tasks/1']}>
    <Route path="/selected-tasks/1">
      <SelectedTasks
        data-testid={testId}
        {...props}
      />,
    </Route>
  </MemoryRouter>,
);

describe('Компонент SelectedTasks', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
