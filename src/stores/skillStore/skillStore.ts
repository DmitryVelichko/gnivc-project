import { makeAutoObservable, runInAction } from 'mobx';
import { Option } from '@ff/ui-kit';

import SkillService from '../../services/skillService/skillService';
import { Skill } from '../../types/Skill';

class SkillStore {
  skills: Option[] = [];

  isLoading = true;

  isError = false;

  constructor() {
    makeAutoObservable(this);
    SkillService.getAllSkills()
      .then((data) => {
        this.skills = data.map((skill: Skill) => ({
          key: skill.id,
          label: skill.name,
          value: skill.id.toString(),
        }));
        this.isLoading = false;
      })
      .catch(() => {
        this.isError = true;
      });
  }

  getAllSkills = async () => {
    this.isLoading = true;
    this.isError = false;

    try {
      const data = await SkillService.getAllSkills();
      runInAction(() => {
        this.skills = data.map((skill: Skill) => ({
          key: skill.id,
          label: skill.name,
          value: skill.id.toString(),
        }));
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

export default new SkillStore();
