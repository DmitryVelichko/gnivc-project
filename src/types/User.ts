import { Skill } from './Skill';

type User = {
  id: number;
  guid: string;
  name: string;
  email: string;
  learnedSkills?: Skill[];
  wantedSkills?: Skill[];
};

export default User;
