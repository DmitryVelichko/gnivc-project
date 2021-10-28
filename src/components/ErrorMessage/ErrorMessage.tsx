import React from 'react';

import styles from './ErrorMessage.module.scss';

type ErrorMessageProps = {
  children: React.ReactNode
};

const ErrorMessage: React.FC<ErrorMessageProps> = ({ children }) => (
  <div className={styles.component}>
    {children}
  </div>
);

export default ErrorMessage;
