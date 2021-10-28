import { makeAutoObservable } from 'mobx';

class AppStore {
  isError = false;

  constructor() {
    makeAutoObservable(this);
  }

  setError = () => {
    this.isError = !this.isError;
  };
}

export default new AppStore();
