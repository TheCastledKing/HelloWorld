exports.handler = function (event, context, callback) {
  var response = {
    statusCode: 200,
    headers: {
      'Content-Type': 'text/html; charset=utf-8',
    },
    body: '<p>Hello world!</p>',
  }
  function replace(){
  var text = document.getElementById("textarea").value;
  var newText = text.replace(document.write('Hello' + " " + text +'!'));
  document.getElementById("textarea").value = newText;
  callback(null, response)
}
