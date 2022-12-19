require 'json'
file = File.open("./input")
input = file.read.split("\n")

# returns true if order is correct
def compare(left, right, j)
  leftVal = (left.is_a? Array)? left[j] : left
  rightVal = (right.is_a? Array) ? right[j] : right

  # If the left list runs out of items first, the inputs are in the right order.
  if leftVal == nil && rightVal != nil then
    return true
  elsif rightVal == nil && leftVal != nil then
    return false
  elsif leftVal == nil && rightVal == nil then
    return 1
  end

  if(leftVal.is_a? Integer) && (rightVal.is_a? Integer) then
    if(leftVal < rightVal) then
      return true
    elsif leftVal > rightVal
      return false
    elsif leftVal == rightVal
      return compare(left, right, j+1)
    end

  elsif(leftVal.is_a? Array) && (rightVal.is_a? Array) then
    result = compare(leftVal, rightVal, 0)
    if result == 1 then
      return compare(left, right, j+1)
    end
    return result

  elsif(leftVal.is_a? Integer) && (rightVal.is_a? Array) then
    left[j] = [leftVal]
    return compare(left, right, j)
  elsif(rightVal.is_a? Integer) && (leftVal.is_a? Array) then
    right[j] = [rightVal]
    return compare(left, right, j)
  end
end

i=0
pairIndexSum=0

while(input[i]!=nil)
  pairIndex=i/3+1
  left=JSON.parse(input[i])
  right=JSON.parse(input[i+1])

  if compare left, right, 0 then
    pairIndexSum += pairIndex
  end

  i+=3
end

puts(pairIndexSum)

# part 2
input.push("[[2]]")
input.push("[[6]]")

sortedList = input.select {|elt| elt != "" }.sort do |a, b|
  (compare JSON.parse(a), JSON.parse(b), 0) ? -1 : 1
end

index1 = sortedList.find_index("[[2]]") + 1
index2 = sortedList.find_index("[[6]]") + 1

puts(index1*index2)