var express = require("express"),
    versionInfo = require("./version"),
    app = express();

app.listen(process.env.PORT || 3000, function() {
  console.log('Express listening on port 3000');
});

app.get("/", function (req, res) {
  res.send("This application is in version " + versionInfo.version +
    " and was built on " + versionInfo.timestamp);
});

