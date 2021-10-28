import React from 'react';
import { render } from '@testing-library/react';

import TasksSkeleton from '../TasksSkeleton';

const testId = 'testingTasksSceleton';

type TasksSceletonProps = React.ComponentProps<typeof TasksSkeleton>;

const renderComponent = (props: TasksSceletonProps = {}) => render(
  <TasksSkeleton
    data-testid={testId}
    {...props}
  />,
);

describe('Компонент TasksSkeleton', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
