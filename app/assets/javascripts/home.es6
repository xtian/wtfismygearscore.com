(() => {
  if (!Turbolinks.supported) { return; }

  let $ = (selector, context = document) => context.querySelector(selector);
  let form = $('.js-redirectForm');

  form.addEventListener('submit', (ev) => {
    ev.preventDefault();

    let url = '/' + ['region', 'realm', 'name']
      .map((key) => $(`.js-redirectForm-${key}`, form))
      .map((el) => el && el.value)
      .filter(Boolean)
      .join('/');

    Turbolinks.visit(url);
  });
}());
