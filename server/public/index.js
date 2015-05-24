function Ui() {
  var me = this;
  this.prompt    = document.querySelector('.prompt');
  this.input     = document.querySelector('.input');
  this.inputText = this.input.querySelector('.input_text');
  this.ws        = new WebSocket('ws://localhost:3000/');
  this.input.addEventListener('submit', function (evt) {
    evt.preventDefault();
    var text = me.inputText.value;
    me.inputText.value = '';
    me.ws.send(text);
    me.prompt.innerHTML = '<p class="prompt_you">' + text + '</p>' + me.prompt.innerHTML;
  });
  this.ws.onopen = function (evt) {
  };
  this.ws.onmessage = function (evt) {
    me.prompt.innerHTML = '<p class="prompt_me">' + evt.data + '</p>' + me.prompt.innerHTML;
  };
  this.ws.onclose = function (evt) {
  };
  this.ws.onerror = function (evt) {
  };
}

window.addEventListener('DOMContentLoaded', function () {
  new Ui();
});
