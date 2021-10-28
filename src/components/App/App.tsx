import React from 'react';
import { Route, Switch } from 'react-router-dom';
import '@ff/ui-kit/lib/styles/fns.theme.css';
import { useKeycloak } from '@react-keycloak/web';
import { Modal } from '@ff/ui-kit';
import { observer } from 'mobx-react-lite';

import Home from '../routes/Home';
import styles from './App.module.scss';
import Header from '../layouts/Header';
import Footer from '../layouts/Footer';
import ProfileUser from '../routes/ProfileUser';
import TaskContent from '../routes/TaskContent';
import TasksCatalog from '../routes/TasksCatalog';
import Loader from '../Loader';
import TaskForm from '../routes/TaskForm';
import Container from '../layouts/Container';
import OwnTasks from '../routes/OwnTasks';
import SelectedTasks from '../routes/SelectedTasks';
import AppStore from '../../stores/appStore/AppStore';

const NotFound = React.lazy(() => import('../routes/NotFound'));

const App: React.FC = observer(() => {
  const { initialized } = useKeycloak();

  return (
    <div className={styles.component}>
      {!initialized ? (
        <Loader />
      ) : (
        <>
          <Header />
          <Container>
            <Switch>
              <Route exact path="/" component={Home} />
              <Route exact path="/tasks" component={TasksCatalog} />
              <Route
                exact
                path="/selected-tasks/:tab"
                component={SelectedTasks}
              />
              <Route exact path="/own-tasks/:tab" component={OwnTasks} />
              <Route exact path="/add-task" component={TaskForm} />
              <Route exact path="/edit-task/:id" component={TaskForm} />
              <Route exact path="/profile" component={ProfileUser} />
              <Route exact path="/profile/:id" component={ProfileUser} />
              <Route exact path="/tasks/:id" component={TaskContent} />
              <Route path="*" component={NotFound} />
            </Switch>
          </Container>

          <Modal
            anchor="root"
            title="Что-то пошло не так..."
            visible={AppStore.isError}
            onClose={AppStore.setError}
          />
          <Footer />
        </>
      )}
    </div>
  );
});

export default App;
