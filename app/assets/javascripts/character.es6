(() => {
  let container = $('.js-characterContainer');
  let meta = $('meta[name="js-characterData"]');

  let characterData = {
    id: meta.id,
    timestamp: meta.getAttribute('timestamp')
  };

  let cable = ActionCable.createConsumer();

  let updater = cable.subscriptions.create('CharacterUpdateChannel', {
    connected() {
      this.perform('follow', characterData);
    },

    received(data) {
      container.innerHTML = data.character;
    }
  });
}());
