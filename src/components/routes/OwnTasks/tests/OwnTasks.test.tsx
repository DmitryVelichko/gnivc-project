import React from 'react';
import { render } from '@testing-library/react';
import { MemoryRouter, Route } from 'react-router-dom';

import OwnTasks from '../OwnTasks';

const testId = 'testingOwnTasks';

type OwnTasksProps = React.ComponentProps<typeof OwnTasks>;

const renderComponent = (props: OwnTasksProps = {}) => render(
  <MemoryRouter initialEntries={['/own-tasks/1']}>
    <Route path="/own-tasks/1">
      <OwnTasks
        data-testid={testId}
        {...props}
      />
    </Route>
  </MemoryRouter>,
);

describe('Компонент OwnTasks', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
