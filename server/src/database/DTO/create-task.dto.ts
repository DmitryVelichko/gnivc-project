import Skill from '../models/skill';
import File from '../models/file';

export type CreateTaskDTO = {
  ownerId: number;
  name: string;
  description: string;
  price: number;
  link?: string;
  duration: number;
  dueDate: Date;
  weight: number;
  skills?: Skill[];
  attachments?: File[];
}
