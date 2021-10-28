import React from 'react';

import classes from './Container.module.scss';

const Container: React.FC = (props) => (
  <div className={classes.container}>
    {props.children}
  </div>
);

export default Container;
