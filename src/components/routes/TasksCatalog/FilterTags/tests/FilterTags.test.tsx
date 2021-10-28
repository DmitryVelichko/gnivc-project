import React from 'react';
import { render } from '@testing-library/react';

import FilterTags from '../FilterTags';

const testId = 'testingFilterTags';

type FilterTagsProps = React.ComponentProps<typeof FilterTags>;

const renderComponent = (props: FilterTagsProps = {}) => render(
  <FilterTags
    data-testid={testId}
    {...props}
  />,
);

describe('Компонент FilterTags', () => {
  it('отображается без ошибок', () => {
    expect(renderComponent).not.toThrow();
  });
});
