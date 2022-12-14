
const fs = require('fs');
const totalSpace = 70000000
const neededSpace = 30000000
let currentDirectory = ''
let fileTree = {}
let currentFolder = fileTree
let folderSum = 0
let folderList = []

fs.readFile('./input', 'utf8', (err, input) => {
  if (err) {
    console.error(err);
    return;
  }

  input.split('\n').forEach(line => {
    if (line.startsWith("$")) {
      runCmd(line.slice(2))
    } else {
      addElt(line)
    }
  })

  currentDirectory = '/'
  getSize(fileTree, currentDirectory)

  console.log(folderSum)

  let sizeOfRoot = 0
  for (const [key, value] of Object.entries(fileTree)) {
    if (typeof value === 'object') {
      sizeOfRoot += folderList.find(fol => fol.key === `/${key}/`).size
    } else {
      sizeOfRoot += value
    }
  }

  console.log('size of root = ' + sizeOfRoot)

  let toFree = (neededSpace - (totalSpace - sizeOfRoot))
  console.log('smallest folder possible = ' + Math.min(...folderList.filter(fol => fol.size >= toFree).map(fol => fol.size)))
});

const runCmd = cmd => {
  if (cmd.startsWith("cd")) {
    cd(cmd.slice(3))
  }
}

const cd = dirName => {
  if(dirName === '/') {
    currentDirectory = '/'
    currentFolder = fileTree
  } else if(dirName === '..') {
    let tempo = currentDirectory.split('/').slice(1, -2)                // array of folder names
    currentDirectory = tempo.length ? '/' + tempo.join('/') + '/' : '/' // avoid // when we "cd .." back to root
    currentFolder = fileTree
    tempo.forEach(dir => {
      currentFolder = currentFolder[dir]
    })
  } else {
    currentDirectory += dirName + '/'
    currentFolder = currentFolder[dirName]
  }
}

const addElt = line => {
  if (line.startsWith('dir')) {
    currentFolder[line.slice(4)] = {}
  } else {
    currentFolder[line.split(' ')[1]] = parseInt(line.split(' ')[0]) 
  }
}

const getSize = (folder, dir) => {
  let size = 0
  for (const [key, value] of Object.entries(folder)) {
    if (typeof value === 'object') {
      let folderSize = getSize(value, dir+key+'/')  // beware of folder with common names
      size+=folderSize
      folderList.push({key: dir+key+'/', "size": folderSize})
    } else {
      size+=value
    }
  }

  if (size < 100000) {
    folderSum+= size
  }
  return size
}
