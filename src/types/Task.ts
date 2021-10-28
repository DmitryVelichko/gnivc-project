import { Skill } from './Skill';
import Status from './Status';
import User from './User';

export type TaskFile = {
  id: number;
  filename: string;
  size: number;
};

export type TaskDetails = {
  id: number;
  owner: User;
  selectedApplicant?: User;
  applicants?: User[];
  skills?: Skill[];
  attachments?: TaskFile[];
  name: string;
  description: string;
  price: number;
  link?: string;
  duration: number;
  dueDate: string;
  weight: number;
  status: Status;
  views?: number;
  createdAt?: string;
};

export type Task = Omit<
TaskDetails,
'description' | 'link' | 'createdAt' | 'attachments'
>;
