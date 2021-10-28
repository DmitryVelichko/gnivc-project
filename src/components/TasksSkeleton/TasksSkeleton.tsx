import React from 'react';

import styles from './TasksSkeleton.module.scss';

const elements = Array.from(Array(6).keys());

const TasksSkeleton: React.FC = () => (
  <div className={styles.component}>
    {elements.map((el) => (
      <div key={el} className={styles.skeleton} />
    ))}
  </div>
);

export default TasksSkeleton;
