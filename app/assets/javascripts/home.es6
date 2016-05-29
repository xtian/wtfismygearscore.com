(() => {
  function initContentToggle() {
    let toggleable = $$('.js-toggleable');

    $('.js-toggleContent').addEventListener('click', (ev) => {
      ev.preventDefault();
      toggleable.forEach((el) => el.classList.toggle('is-collapsed'));
    });
  }

  function initForm() {
    if (!Turbolinks.supported) { return; }

    let form = $('.js-redirectForm');

    form.addEventListener('submit', (ev) => {
      ev.preventDefault();

      let url = '/' + ['region', 'realm', 'name']
        .map((key) => $(`.js-redirectForm-${key}`, form))
        .map((el) => el && el.value.trim())
        .filter(Boolean)
        .join('/');

      Turbolinks.visit(url);
    });
  }

  initContentToggle();
  initForm();
}());
