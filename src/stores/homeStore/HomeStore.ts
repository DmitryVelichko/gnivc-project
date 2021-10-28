import { makeAutoObservable, runInAction } from 'mobx';

import TaskService from '../../services/taskService/taskService';
import { Task } from '../../types/Task';

class OwnTasksStore {
  tasks: Task[] = [];

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
      const data = await TaskService.getInterestingTasks();
      runInAction(() => {
        this.tasks = data;
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
  };
}

export default new OwnTasksStore();
