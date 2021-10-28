import React from 'react';
import { render } from '@testing-library/react';

import Footer from '../Footer';

const testId = 'testingFooter';

type FooterProps = React.ComponentProps<typeof Footer>;

const renderComponent = (props: FooterProps = {}) => render(
  <Footer
    data-testid={testId}
    {...props}
  />,
);

describe('Компонент Footer', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
