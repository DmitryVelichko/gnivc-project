import React from 'react';
import { render } from '@testing-library/react';

import SortBar from '../SortBar';

const testId = 'testingSortBar';

type SortBarProps = React.ComponentProps<typeof SortBar>;

const renderComponent = (props: SortBarProps = {}) => render(
  <SortBar
    data-testid={testId}
    {...props}
  />,
);

describe('Компонент SortBar', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
