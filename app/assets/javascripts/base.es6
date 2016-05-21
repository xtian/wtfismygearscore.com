(() => {
  window.$ = (selector, context = document) => context.querySelector(selector);
}());
