
const fs = require('fs');

fs.readFile('./input', 'utf8', (err, input) => {
  if (err) {
    console.error(err);
    return;
  }
  let elves = input.slice(0, -1).split('\n\n')
  let elvesTotal = elves.map(e => e.split('\n').reduce((total, cal) => total + parseInt(cal), 0))
  let bestElf = Math.max(...elvesTotal)
  console.log(bestElf)

  let best3Elves = elvesTotal.sort((a, b) => b - a).splice(0,3)
  let sumOfBest3Elves = best3Elves.reduce((total, cal) => total + parseInt(cal), 0)
  console.log(sumOfBest3Elves)
});

