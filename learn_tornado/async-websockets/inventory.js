function requestInventory() {
    var host = 'ws://localhost:8000/cart/status';

    var websocket = new WebSocket(host);

    websocket.onopen = function (evt) { };
    websocket.onmessage = function(evt) {
        $('#count').html($.parseJSON(evt.data)['inventoryCount']);
    };
    websocket.onerror = function (evt) { };
}
