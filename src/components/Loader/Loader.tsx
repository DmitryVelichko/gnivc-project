import React from 'react';

import styles from './Loader.module.scss';

const Loader: React.FC = () => (
  <div className={styles.snippet} data-title=".dot-spin">
    <div className={styles.stage}>
      <h1>БИРЖА ЗАДАЧ</h1>
      <div className={styles.dotSpin} />
      <h2>Авторизация пользователя...</h2>
    </div>
  </div>
);

export default Loader;
