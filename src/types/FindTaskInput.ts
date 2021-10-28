export type FindTasksInput = {
  offset?: number;
  limit: number;
  orderBy?: string;
  orderDirection?: 'ASC' | 'DESC';
  owner?: number;
  priceFrom?: string;
  priceTo?: string
  skills?: string[]
  dueDateFrom?: string;
  dueDateTo?: string;
  weightFrom?: string
  weightTo?: string;
  status?: string[]
};
