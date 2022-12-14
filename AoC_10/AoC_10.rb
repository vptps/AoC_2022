file = File.open("./input")
input = file.read.split("\n")

i=0
x=1
stack=[]
signalStrength = 0
crt=[]
currentCRTRow=""

while (input[i]!=nil || stack.length > 0)
  # puts("cycle " + (i+1).to_s + ", ligne: " + input[i].to_s + ", X vaut :" + x.to_s)

  # read line while there are lines and add instruction to stack
  if (input[i] != nil) then
    if input[i] == "noop" then
      stack.unshift(false)
    else
      stack.unshift(false)
      stack.unshift(input[i].split(" ")[1])
    end
  end

  #check signal strength
  case i 
  when 19
    signalStrength += 20*x
  when 59
    signalStrength += 60*x
  when 99
    signalStrength += 100*x
  when 139
    signalStrength += 140*x
  when 179
    signalStrength += 180*x
  when 219
    signalStrength += 220*x
  end

  # check crt at end of cycle
  # crtLine="........................................"
  # crtLine[x-1]="#"
  # crtLine[x]="#"
  # crtLine[x+1]="#"
  # puts(crtLine)
  # puts(currentCRTRow)
  if (currentCRTRow.length.between?(x-1, x+1)) then
    currentCRTRow+="#"
  else 
    currentCRTRow+="."
  end
  if((i+1)%40 === 0) then
    crt.push(currentCRTRow)
    currentCRTRow=""
  end

  # pop instruction and execute
  instruction=stack.pop()
  # puts("instruction to execute this cycle is " + instruction.to_s)
  if instruction then
    x+=instruction.to_i
  end
  # puts("at end of cycle " + (i+1).to_s + " x = " + x.to_s)

  i+=1
end

puts(signalStrength)
puts(crt)
