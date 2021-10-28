import { makeAutoObservable, runInAction } from 'mobx';
import { Option, StringDateObject } from '@ff/ui-kit';
import { omit } from 'lodash';

import TaskService from '../../services/taskService/taskService';
import scrollToTop from '../../lib/smoothScroll';
import { FindTasksInput } from '../../types/FindTaskInput';
import formatDateToDB from '../../utils';
import { Task } from '../../types/Task';

class TasksCatalogStore {
  tasks: Task[] = [];

  count = 0;

  page = 1;

  tasksPerList = 20;

  isLoading = true;

  isError = false;

  owners: Option[] = [];

  search = '';

  filter: Partial<FindTasksInput> = {};

  filterOwner: number | undefined;

  filterSkills: string[] | undefined;

  dateFilter: StringDateObject = { start: '', end: '' };

  constructor() {
    makeAutoObservable(this);
    this.getOwners();
  }

  getOwners() {
    TaskService.getTaskOwners().then((owners) => {
      runInAction(() => {
        this.owners = owners.map((owner: { id: number; name: string }) => ({
          key: owner.id,
          label: owner.name,
          value: owner.id.toString(),
        }));
      });
    });
  }

  setPage = async (newPage: number) => {
    this.page = newPage;
  };

  omitFilter = async (key: string) => {
    if (key === 'dueDateFrom') {
      this.dateFilter.start = '';
    }
    if (key === 'dueDateTo') {
      this.dateFilter.end = '';
    }
    if (key === 'owner') {
      this.filterOwner = undefined;
    }

    if (key === 'skills') {
      this.filterSkills = undefined;
    }
    this.filter = { ...omit(this.filter, [key]) };
    await this.fetchTasks();
  };

  patchFilter = (patch: Partial<FindTasksInput>) => {
    this.filter = { ...this.filter, ...patch };
  };

  resetFilter = () => {
    this.dateFilter = { start: '', end: '' };
    this.filterOwner = undefined;
    this.filter = {};
    this.filterSkills = undefined;
    this.setPage(1);
    this.fetchTasks();
  };

  setFilterDates = (dates: StringDateObject) => {
    this.dateFilter = { start: dates.start, end: dates.end };
    this.patchFilter({
      ...(dates.start && { dueDateFrom: formatDateToDB(dates.start) }),
      ...(dates.end && { dueDateTo: formatDateToDB(dates.end) }),
    });
  };

  setFilterOwner = (owner: number) => {
    this.filterOwner = owner;
    this.patchFilter({ owner });
  };

  setFilterSkills = (skills: string[]) => {
    this.filterSkills = skills;
    this.patchFilter({ skills });
  };

  sort = (cloumn: string) => {
    this.filter.orderBy = cloumn;
    this.filter.orderDirection = this.filter.orderDirection === 'ASC' ? 'DESC' : 'ASC';
    this.setPage(1);
    this.fetchTasks();
  };

  fetchTasks = async () => {
    this.isLoading = true;
    this.isError = false;

    try {
      const offset = this.tasksPerList * (this.page - 1);
      const input = {
        limit: this.tasksPerList,
        offset,
        ...omit(this.filter, ['dateFilter']),
      };
      const { rows, count } = await TaskService.findTasks(input);
      runInAction(() => {
        this.tasks = rows;
        this.count = count;
      });
    } catch {
      runInAction(() => {
        this.isError = true;
      });
    } finally {
      runInAction(() => {
        this.isLoading = false;
        scrollToTop();
      });
    }
  };

  clearTasks = () => {
    this.tasks = [];
    this.setPage(1);
    this.isLoading = true;
    this.isError = false;
  };

  setSearch = (event: React.ChangeEvent<HTMLInputElement>) => {
    this.search = event.target.value;
  };
}

export default new TasksCatalogStore();
