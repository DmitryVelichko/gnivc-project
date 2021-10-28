import React, { FC } from 'react';
import { Button, Icon, Row } from '@ff/ui-kit';
import { NavLink, useLocation } from 'react-router-dom';
import { useKeycloak } from '@react-keycloak/web';
import { get } from 'lodash';

import styles from './Header.module.scss';
import logo from './assets/gnivc-logo.png';

const Header: FC = () => {
  const { keycloak } = useKeycloak();

  function logout() {
    keycloak.logout();
  }

  const location = useLocation();

  const Popup = (
    <div id="profile-popup" className={styles.popup}>
      <NavLink exact to="/profile" className={styles.popupItem}>
        <Icon
          fontSize={18}
          name="person"
          color="#224b8d"
          className={styles.profileIcon}
        />
        <span className={styles.profileNameLink}>Профиль</span>
      </NavLink>

      <button type="button" className={styles.popupItem} onClick={logout}>
        <Icon
          fontSize={18}
          name="door_open"
          color="#224b8d"
          className={styles.profileIcon}
        />
        Выйти
      </button>
    </div>
  );

  return (
    <Row className={styles.component} justify="space-between">
      <div className={styles.left}>
        <NavLink to="/" className={styles.logo}>
          <img src={logo} alt="gnivc logo" />
        </NavLink>

        <NavLink
          exact
          className={styles.link}
          activeClassName={styles.activeLink}
          to="/"
        >
          Главная
        </NavLink>
        <NavLink
          className={styles.link}
          activeClassName={styles.activeLink}
          to="/tasks"
        >
          Задачи
        </NavLink>
        <NavLink
          className={styles.link}
          activeClassName={styles.activeLink}
          to="/selected-tasks/1"
          isActive={() => location.pathname.includes('/selected-tasks')}
        >
          Выбранные задачи
        </NavLink>
        <NavLink
          className={styles.link}
          activeClassName={styles.activeLink}
          to="/own-tasks/1"
          isActive={() => location.pathname.includes('/own-tasks')}
        >
          Мои задачи
        </NavLink>
      </div>

      <div className={styles.right}>
        <NavLink exact to="/add-task" className={styles.popupItem}>
          <Button size="small">Добавить задачу</Button>
        </NavLink>

        <div className={styles.profile}>
          <Icon name="person" color="#fff" className={styles.profileIcon} />
          <span className={styles.profileName}>
            {get(keycloak, ['tokenParsed', 'preferred_username'])}
          </span>
          <Icon
            name="chevron_down"
            color="#fff"
            className={styles.profileChevron}
          />
          {Popup}
        </div>
      </div>
    </Row>
  );
};

export default Header;
