Shiny.addCustomMessageHandler("reroute", function (message) {
  console.log(message);
  window.location.href = message;
});
