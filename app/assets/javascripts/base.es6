(() => {
  window.$ = (selector, context = document) => context.querySelector(selector);
  window.$$ = (selector, context = document) => context.querySelectorAll(selector);
}());
