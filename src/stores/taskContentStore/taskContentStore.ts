import {
  makeAutoObservable,
  runInAction,
} from 'mobx';

import TaskService from '../../services/taskService/taskService';
import { TaskDetails } from '../../types/Task';

class TaskContentStore {
  task: TaskDetails | null = null;

  userToken = '';

  userIsOwner = false;

  userIsApplicant = false;

  userIsSelectedApplicant = false;

  isLoading = true;

  isError = false;

  constructor() {
    makeAutoObservable(this);
  }

  fetchTask = async (id: number, userToken: string) => {
    runInAction(() => {
      this.isLoading = true;
      this.isError = false;
    });
    try {
      const task = await TaskService.getTask(id);
      runInAction(() => {
        this.task = task;
        this.userToken = userToken;

        this.userIsApplicant = Boolean(
          task.applicants?.find((ap) => ap.guid === userToken),
        );
        this.userIsSelectedApplicant = task.selectedApplicant?.guid === userToken;

        this.userIsOwner = task.owner.guid === userToken;
      });
    } catch {
      runInAction(() => {
        this.isError = true;
      });
    } finally {
      runInAction(() => {
        this.isLoading = false;
      });
    }
  };
}

export default new TaskContentStore();
