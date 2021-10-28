import React from 'react';
import { render } from '@testing-library/react';

import Loader from '../Loader';

const testId = 'testingLoader';

type LoaderProps = React.ComponentProps<typeof Loader>;

const renderComponent = (props: LoaderProps = {}) => render(
  <Loader
    data-testid={testId}
    {...props}
  />,
);

describe('Компонент Loader', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
