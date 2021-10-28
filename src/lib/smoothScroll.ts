const scrollToTop = (): void => {
  const root = document.querySelector('#root');

  if (root) {
    root.scrollIntoView({
      behavior: 'smooth',
      block: 'start',
    });
  }
};
export default scrollToTop;
