#                 [B]     [L]     [S]
#         [Q] [J] [C]     [W]     [F]
#     [F] [T] [B] [D]     [P]     [P]
#     [S] [J] [Z] [T]     [B] [C] [H]
#     [L] [H] [H] [Z] [G] [Z] [G] [R]
# [R] [H] [D] [R] [F] [C] [V] [Q] [T]
# [C] [J] [M] [G] [P] [H] [N] [J] [D]
# [H] [B] [R] [S] [R] [T] [S] [R] [L]
#  1   2   3   4   5   6   7   8   9 
import re


################# FIRST PART ######################
arr1 = ['H', 'C', 'R']
arr2 = ['B', 'J', 'H', 'L', 'S', 'F']
arr3 = ['R', 'M', 'D', 'H', 'J', 'T', 'Q']
arr4 = ['S', 'G', 'R', 'H', 'Z', 'B', 'J']
arr5 = ['R', 'P', 'F', 'Z', 'T', 'D', 'C', 'B']
arr6 = ['T', 'H', 'C', 'G']
arr7 = ['S', 'N', 'V', 'Z', 'B', 'P', 'W', 'L']
arr8 = ['R', 'J', 'Q', 'G', 'C']
arr9 = ['L', 'D', 'T', 'R', 'H', 'P', 'F', 'S']
stacks = {1:arr1, 2:arr2, 3:arr3, 4:arr4, 5:arr5, 6:arr6, 7:arr7, 8:arr8, 9:arr9}

with open('input') as f:
  line = f.readline().rstrip('\n')
  while line != '':
    lineArray = [int(s) for s in re.findall(r'\d+', line)]

    # quantity, fromStack, toStack
    quantity = lineArray[0]
    fromStack = stacks[lineArray[1]]
    toStack = stacks[lineArray[2]]

    toStack.extend(fromStack[len(fromStack)-quantity:len(fromStack)])
    for _ in range(quantity): fromStack.pop()

    line = f.readline().rstrip('\n')
  print('first problem')
  for i in stacks : print(stacks[i][len(stacks[i]) - 1])
f.close()

################## SECOND PART #####################
arr1 = ['H', 'C', 'R']
arr2 = ['B', 'J', 'H', 'L', 'S', 'F']
arr3 = ['R', 'M', 'D', 'H', 'J', 'T', 'Q']
arr4 = ['S', 'G', 'R', 'H', 'Z', 'B', 'J']
arr5 = ['R', 'P', 'F', 'Z', 'T', 'D', 'C', 'B']
arr6 = ['T', 'H', 'C', 'G']
arr7 = ['S', 'N', 'V', 'Z', 'B', 'P', 'W', 'L']
arr8 = ['R', 'J', 'Q', 'G', 'C']
arr9 = ['L', 'D', 'T', 'R', 'H', 'P', 'F', 'S']
stacks = {1:arr1, 2:arr2, 3:arr3, 4:arr4, 5:arr5, 6:arr6, 7:arr7, 8:arr8, 9:arr9}

with open('input') as f:
  line = f.readline().rstrip('\n')
  while line != '':
    lineArray = [int(s) for s in re.findall(r'\d+', line)]

    # quantity, fromStack, toStack
    quantity = lineArray[0]
    fromStack = stacks[lineArray[1]]
    toStack = stacks[lineArray[2]]

    toStack.extend(reversed(fromStack[len(fromStack)-quantity:len(fromStack)]))
    for _ in range(quantity): fromStack.pop()

    line = f.readline().rstrip('\n')
  print('second problem')
  for i in stacks : print(stacks[i][len(stacks[i]) - 1])
f.close()
