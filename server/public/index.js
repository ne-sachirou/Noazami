function speak(ws) {
  var sentences = ['マジで', 'ヤバい', 'ウケる―'];
  ws.send(sentences[Math.floor(Math.random() * sentences.length)]);
  setTimeout(function () {
    speak(ws);
  }, Math.floor(Math.random() * 10) * 1000 + 3000);
}

window.addEventListener('DOMContentLoaded', function () {
  var ws = new WebSocket('ws://localhost:3000/');
  ws.onopen = function (evt) {
    speak(ws);
  };
  ws.onmessage = function (evt) {
  };
  ws.onclose = function (evt) {
  };
  ws.onerror = function (evt) {
  };
});
