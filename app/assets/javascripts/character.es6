(() => {
  let cable = ActionCable.createConsumer();
  let selector = '.js-characterContainer'

  let updater = cable.subscriptions.create('CharacterUpdateChannel', {
    connected() {
      this.follow();
      this.installVisitHandler();
    },

    received(data) {
      $(`${selector}[data-id="${data.id}"]`).innerHTML = data.html
    },

    follow() {
      let data = this.followData();

      if (data) {
        this.perform('follow', data);
      } else {
        this.perform('unfollow');
      }
    },

    followData() {
      let el = $(selector);

      return el && {
        id: el.dataset.id,
        timestamp: el.dataset.timestamp
      };
    },

    installVisitHandler() {
      if (this._visitHandlerInstalled) { return; }

      this._visitHandlerInstalled = true;
      document.addEventListener('turbolinks:visit', () => this.follow());
    }
  });
}());
