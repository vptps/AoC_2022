const fs = require('fs');
let gridHeight 
let gridWidth

fs.readFile('./input', 'utf8', (err, input) => {
  if (err) {
    console.error(err);
    return;
  }

  let lines = input.split('\n')
  let countVisible = 0
  let viewingField = 0
  let a = 0
  let b = 0
  let c = 0
  let d = 0
  let line = ''
  let isVisible = false
  gridHeight = lines.length
  gridWidth = lines[0].length

  for(let i=0; i < gridHeight ; i++) {
    line = lines[i]
    for(let j=0; j < gridWidth; j++) {
      let result = []
      isVisible = false
      a = 0
      b = 0
      c = 0
      d = 0

      result = checkLeft(j, line)
      isVisible = isVisible || result[0]
      a = result[1]

      result = checkTop(i, j, lines)
      isVisible = isVisible || result[0]
      b = result[1]

      result = checkRight(j, line)
      isVisible = isVisible || result[0]
      c = result[1]

      result = checkBottom(i, j, lines)
      isVisible = isVisible || result[0]
      d = result[1]

      if (isVisible) {
        countVisible++
      }

      viewingField = Math.max(viewingField, a*b*c*d)
    }
  }
  console.log(countVisible, viewingField)

});

const checkLeft = (j, line) => {
  let count = 0
  if (j===0) return [true, count]
  for(let k =j-1; k>=0 ; k--){
    count++
    if (parseInt(line[k]) >= parseInt(line[j])) {
      return [false, count]
    }
  }
  return [true, count]
}

const checkTop = (i, j, lines) => {
  let count = 0
  if (i===0) return [true, count]
  for(k = i-1; k>=0 ; k--) {
    count++
    if (parseInt(lines[k][j]) >= parseInt(lines[i][j])) {
      return [false, count]
    }
  }
  return [true, count]
}

const checkRight = (j, line) => {
  let count = 0
  if (j===gridWidth-1) return [true, count]
  for(let k=j+1; k<=gridWidth-1 ; k++){
    count++
    if (parseInt(line[k]) >= parseInt(line[j])) {
      return [false, count]
    }
  }
  return [true, count]
}

const checkBottom = (i, j, lines) => {
  let count = 0
  if (i===gridHeight+1) return [true, count]
  for(k = i+1; k<=gridHeight-1; k++) {
    count++
    if (parseInt(lines[k][j]) >= parseInt(lines[i][j])) {
      return [false, count]
    }
  }
  return [true, count]
}