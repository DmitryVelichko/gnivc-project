export type CreateTaskInputType = {
  skills?: number[];
  attachments?: File[];
  name: string;
  description: string;
  price: number;
  link?: string;
  duration: number;
  dueDate: string;
  weight: number;
};

export type UpdateTaskInputType = {
  skills?: number[];
  newAttachments?: File[];
  oldAttachments?: number[];
  name?: string;
  description?: string;
  price?: number;
  link?: string;
  duration?: number;
  dueDate?: string;
  weight?: number;
};
