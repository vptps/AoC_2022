const fs = require('fs');

fs.readFile('./input', 'utf8', (err, input) => {
  if (err) {
    console.error(err);
    return;
  }
  console.log(input);
});

