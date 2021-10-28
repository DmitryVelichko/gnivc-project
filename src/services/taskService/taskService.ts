import axios from 'axios';

import { CreateTaskInputType, UpdateTaskInputType } from './inputTypes';
import { FindTasksInput } from '../../types/FindTaskInput';
import { Task, TaskDetails } from '../../types/Task';
import User from '../../types/User';

class TaskService {
  taskQueryFragment = `
      id
      name
      price
      owner {
        id
        name
        email
      }
      skills {
        id,
        name
      }
      duration
      dueDate
      weight
      status
      views
      applicants {
        id
      }
      selectedApplicant {
        id
        name
      }
  `;

  // queries

  FIND_TASKS = `
  query findTasks($input: FindTasksInput!) {
    findTasks(input: $input) {
      rows {${this.taskQueryFragment}}
      count
    }
  }
  `;

  GET_OWN_TASKS = `
  query getOwnTasks {
    getOwnTasks {
      ${this.taskQueryFragment}
    }
  }`;

  GET_PARTICIPATED_TASKS = `
  query getParticipatedTasks {
    getParticipatedTasks {
      ${this.taskQueryFragment}
    }
  }`;

  GET_INTERESTING_TASKS = `
  query getInterestingTasks {
    getInterestingTasks {
      ${this.taskQueryFragment}
    }
  }`;

  GET_TASK_OWNERS = `
  query getTaskOwners {
    getTaskOwners {
      name
      id
    }
  }`;

  GET_TASK = `
  query getTask($getTaskId: Int!) {
    getTask(id: $getTaskId) {
      id
      owner {
        id
        guid
        name
      }
      selectedApplicant {
        id
        guid
        name
      }
      applicants {
        id
        guid
        name
      }
      skills {
        name
      }
      attachments {
        id
        filename
        size
      }
      name
      description
      price
      link
      duration
      dueDate
      weight
      status
      views
      createdAt
    }
  }
`;

  // mutations

  CREATE_TASK = `
  mutation CreateTaskMutation($input: CreateTaskInput!) {
    createTask(input: $input) {
      id
    }
  }`;

  UPDATE_TASK = `
  mutation CreateTaskMutation($input: UpdateTaskInput!, $updateTaskId: Int!) {
    updateTask(input: $input, id: $updateTaskId) {
      id
    }
  }
  `;

  DELETE_TASK = `
  mutation DeleteTaskMutation($taskId: Int!) {
    deleteTask(taskId: $taskId)
  }
  `;

  OFFER_TASK = `
  mutation CreateTaskMutation($offerTaskId: Int!) {
    offerTask(id: $offerTaskId) {
      id
    }
  }
  `;

  UNOFFER_TASK = `
  mutation CreateTaskMutation($unOfferTaskId: Int!) {
    unOfferTask(id: $unOfferTaskId) {
      id
    }
  }
  `;

  ASSIGN_TASK = `
  mutation CreateTaskMutation($taskId: Int!, $applicantId: Int!) {
    assignTask(taskId: $taskId, applicantId: $applicantId) {
      id
    }
  }
  `;

  UNASSIGN_TASK = `
  mutation CreateTaskMutation($unAssignTaskTaskId2: Int!) {
    unAssignTask(taskId: $unAssignTaskTaskId2) {
      id
    }
  }
  `;

  START_TASK = `
  mutation Mutation($taskId: Int!) {
    startTask(taskId: $taskId) {
      id
    }
  }
  `;

  CANCEL_TASK = `
  mutation CancelTaskMutation($taskId: Int!) {
    cancelTask(taskId: $taskId) {
      id
    }
  }
  `;

  COMPLETE_TASK = `
  mutation Mutation($taskId: Int!) {
    completeTask(taskId: $taskId) {
      id
    }
  }
  `;

  SUBMIT_APPLICATION = `
  mutation Mutation($taskId: Int!) {
    submitApplication(taskId: $taskId)
  }
  `;

  REVOKE_APPLICATION = `
  mutation Mutation($taskId: Int!) {
    revokeApplication(taskId: $taskId)
  }
  `;

  linkQuery = 'http://localhost:4000/api';

  postQuery = async (
    query: string,
    variables: unknown = {},
    authorization = false,
  ) => {
    const authHeaders = {
      Authorization: localStorage.getItem('token') || '',
    };

    const data = await axios.post(
      this.linkQuery,
      {
        query,
        variables,
      },
      authorization
        ? {
          headers: authHeaders,
        }
        : {},
    );

    return data.data.data;
  };

  findTasks = async (
    input: FindTasksInput,
  ): Promise<{ rows: Task[]; count: number }> => {
    const data = await this.postQuery(this.FIND_TASKS, { input });

    return data.findTasks;
  };

  getOwnTasks = async (): Promise<Task[]> => {
    const data = await this.postQuery(this.GET_OWN_TASKS, {}, true);

    return data.getOwnTasks;
  };

  getParticipatedTasks = async (): Promise<Task[]> => {
    const data = await this.postQuery(this.GET_PARTICIPATED_TASKS, {}, true);

    return data.getParticipatedTasks;
  };

  getInterestingTasks = async (): Promise<Task[]> => {
    const data = await this.postQuery(this.GET_INTERESTING_TASKS, {}, true);

    return data.getInterestingTasks;
  };

  getTaskOwners = async (): Promise<User[]> => {
    const data = await this.postQuery(this.GET_TASK_OWNERS);

    return data.getTaskOwners;
  };

  getTask = async (getTaskId: number): Promise<TaskDetails> => {
    const data = await this.postQuery(this.GET_TASK, { getTaskId });

    return data.getTask;
  };

  createTask = async (input: CreateTaskInputType) => {
    // todo: изменить postquery

    const formData = new FormData();

    const operations = JSON.stringify({
      query: this.CREATE_TASK,
      variables: { input },
    });
    formData.append('operations', operations);

    const map: any = {};
    if (input.attachments) {
      input.attachments.forEach((item, i) => {
        map[i] = [`variables.input.attachments.${i}`];
      });
    }
    formData.append('map', JSON.stringify(map));
    if (input.attachments) {
      input.attachments.forEach((item, i) => {
        formData.append(i.toString(), item);
      });
    }

    const data = await axios({
      url: this.linkQuery,
      method: 'post',
      data: formData,
      headers: { Authorization: localStorage.getItem('token') },
    });
    return data.data.data.createTask;
  };

  updateTask = async (input: UpdateTaskInputType, updateTaskId: number) => {
    const formData = new FormData();

    const operations = JSON.stringify({
      query: this.UPDATE_TASK,
      variables: { input, updateTaskId },
    });
    formData.append('operations', operations);

    const map: any = {};
    if (input.newAttachments) {
      input.newAttachments.forEach((item, i) => {
        map[i] = [`variables.input.newAttachments.${i}`];
      });
    }
    formData.append('map', JSON.stringify(map));
    if (input.newAttachments) {
      input.newAttachments.forEach((item, i) => {
        formData.append(i.toString(), item);
      });
    }

    const data = await axios({
      url: this.linkQuery,
      method: 'post',
      data: formData,
      headers: { Authorization: localStorage.getItem('token') },
    });
    return data.data.data.updateTask;
  };

  deleteTask = async (taskId: number) => {
    const data = await this.postQuery(
      this.DELETE_TASK,
      {
        taskId,
      },
      true,
    );

    return data.deleteTask;
  };

  offerTask = async (offerTaskId: number) => {
    const data = await this.postQuery(
      this.OFFER_TASK,
      {
        offerTaskId,
      },
      true,
    );

    return data.offerTask;
  };

  unofferTask = async (id: number) => {
    const data = await this.postQuery(
      this.UNOFFER_TASK,
      {
        id,
      },
      true,
    );

    return data.unofferTask;
  };

  assignTask = async (taskId: number, applicantId: number) => {
    const data = await this.postQuery(
      this.ASSIGN_TASK,
      {
        taskId,
        applicantId,
      },
      true,
    );

    return data.assignTask;
  };

  unassignTask = async (taskId: number) => {
    const data = await this.postQuery(
      this.UNASSIGN_TASK,
      {
        taskId,
      },
      true,
    );

    return data.unassignTask;
  };

  startTask = async (taskId: number) => {
    const data = await this.postQuery(
      this.START_TASK,
      {
        taskId,
      },
      true,
    );

    return data.startTask;
  };

  cancelTask = async (taskId: number) => {
    const data = await this.postQuery(
      this.CANCEL_TASK,
      {
        taskId,
      },
      true,
    );

    return data.cancelTask;
  };

  completeTask = async (taskId: number) => {
    const data = await this.postQuery(
      this.COMPLETE_TASK,
      {
        taskId,
      },
      true,
    );

    return data.completeTask;
  };

  submitApplication = async (taskId: number) => {
    const data = await this.postQuery(
      this.SUBMIT_APPLICATION,
      {
        taskId,
      },
      true,
    );

    return data.submitApplication;
  };

  revokeApplication = async (taskId: number) => {
    const data = await this.postQuery(
      this.REVOKE_APPLICATION,
      {
        taskId,
      },
      true,
    );

    return data.revokeApplication;
  };
}

export default new TaskService();
