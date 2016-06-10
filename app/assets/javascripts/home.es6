(() => {
  function initContentToggle() {
    let toggleable = $$('.js-toggleable');

    $('.js-toggleContent').addEventListener('click', (ev) => {
      ev.preventDefault();
      toggleable.forEach((el) => el.classList.toggle('is-collapsed'));
    });
  }

  function initFormCache(form) {
    let store = window.localStorage;

    let region = store.getItem('region');
    let realm = store.getItem('realm');

    let regionField = $('.js-redirectForm-region', form);
    let realmField = $('.js-redirectForm-realm', form);

    if (region) { regionField.value = region; }
    if (realm) { realmField.value = realm; }

    form.addEventListener('submit', (ev) => {
      store.setItem('region', regionField.value.trim());
      store.setItem('realm', realmField.value.trim());
    });
  }

  function initFormRedirect(form) {
    if (!Turbolinks.supported) { return; }

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

  let form = $('.js-redirectForm');

  initContentToggle();
  initFormCache(form);
  initFormRedirect(form);
}());
