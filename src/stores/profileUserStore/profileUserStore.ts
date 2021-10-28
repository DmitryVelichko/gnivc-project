import { makeAutoObservable, runInAction } from 'mobx';

import { Skill } from '../../types/Skill';
import UserService from '../../services/userService/userService';
import SkillStore from '../skillStore/skillStore';
import User from '../../types/User';

class ProfileUserStore {
  user: User | null = null;

  wantedSkills: Skill[] = [];

  learnedSkills: Skill[] = [];

  isLoading = false;

  isError = false;

  constructor() {
    makeAutoObservable(this);
  }

  getUserByGUID = async (userGuid: string) => {
    this.isLoading = true;
    this.isError = false;

    try {
      const data = await UserService.getUserByGUID(userGuid);
      runInAction(() => {
        this.user = data;
        this.wantedSkills = data.wantedSkills;
        this.learnedSkills = data.learnedSkills;
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

  getUserByID = async (ID: number) => {
    this.isLoading = true;
    this.isError = false;

    try {
      const data = await UserService.getUserByID(ID);
      runInAction(() => {
        this.user = data;
        this.wantedSkills = data.wantedSkills;
        this.learnedSkills = data.learnedSkills;
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

  updateWantedSkills = async (value: string | string[]) => {
    if (Array.isArray(value)) {
      try {
        this.wantedSkills = SkillStore.skills
          .filter((skill) => value.includes(skill.value))
          .map((skill): Skill => ({
            id: parseInt(skill.key.toString(), 10),
            name: skill.label,
          }));
      } catch {
        runInAction(() => {
          this.isError = true;
        });
      } finally {
        runInAction(() => {
          this.isLoading = false;
        });
      }
    }
  };

  setWantedSkills = async (skills: number[]) => {
    this.isLoading = true;
    this.isError = false;
    try {
      await UserService.setWantedSkills(skills);
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

export default new ProfileUserStore();
