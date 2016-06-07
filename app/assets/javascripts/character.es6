(() => {
  let container = $('.js-characterContainer');

  let characterData = {
    id: container.dataset.id,
    timestamp: container.dataset.timestamp
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
