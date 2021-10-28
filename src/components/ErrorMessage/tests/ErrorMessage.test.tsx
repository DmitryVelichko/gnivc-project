import React from 'react';
import { render } from '@testing-library/react';

import ErrorMessage from '../ErrorMessage';

const testId = 'testingErrorMessage';

type ErrorMessageProps = React.ComponentProps<typeof ErrorMessage>;

const renderComponent = (props: ErrorMessageProps = { children: <div /> }) => render(
  <ErrorMessage
    data-testid={testId}
    {...props}
  />,
);

describe('Компонент ErrorMessage', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
