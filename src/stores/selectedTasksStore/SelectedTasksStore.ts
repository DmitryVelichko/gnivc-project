import {
  makeAutoObservable,
  runInAction,
} from 'mobx';

import TaskService from '../../services/taskService/taskService';
import Status from '../../types/Status';
import { Task } from '../../types/Task';

class OwnTasksStore {
  tasks: Task[] = [];

  currentTasks: Task[] = [];

  finishedTasks: Task[] = [];

  isLoading = true;

  isError = false;

  constructor() {
    makeAutoObservable(this);
  }

  fetchTasks = async () => {
    runInAction(() => {
      this.isLoading = true;
      this.isError = false;
    });

    try {
      const data = await TaskService.getParticipatedTasks();
      runInAction(() => {
        this.tasks = data;
        this.currentTasks = this.tasks.filter(
          (task) => task.status === Status.OFFERED
            || task.status === Status.ASSIGNED
            || task.status === Status.STARTED,
        );
        this.finishedTasks = this.tasks.filter(
          (task) => task.status === Status.CANCELED || task.status === Status.COMPLETED,
        );
      });
    } catch {
      this.clearTasks();
      runInAction(() => {
        this.isError = true;
      });
    } finally {
      runInAction(() => {
        this.isLoading = false;
      });
    }
  };

  clearTasks = () => {
    this.isLoading = true;
    this.isError = false;
    this.tasks = [];
    this.currentTasks = [];
    this.finishedTasks = [];
  };
}

export default new OwnTasksStore();
