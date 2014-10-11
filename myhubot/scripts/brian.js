var Bleacon = require('bleacon');

module.exports = function(robot) {
  Bleacon.startScanning();

  Bleacon.on('discover', function(bleacon) {
    var user = {room: "#chatroom"};
    var message = "ちゅーかねー、";

    if (bleacon.proximity == 'immediate') {
      message += "今席にいます";
    } else {
      message += "ちょと席離れた";
    }

    robot.send(user, message);
  });
};
