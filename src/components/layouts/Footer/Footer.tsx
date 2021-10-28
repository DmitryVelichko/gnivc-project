import React from 'react';

import styles from './Footer.module.scss';

const Footer: React.FC = () => (
  <div className={styles.component}>
    Команда №3 &copy; {new Date().getFullYear()}
  </div>
);

export default Footer;
