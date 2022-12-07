file = File.open("./input")
input = file.read

hasShownMarker = false
markerSize = 4
messageSize = 14

for i in 0..input.length-1
  isMarker = true
  marker = input[i..i+markerSize-1]
  for j in 0..markerSize-1
    if marker[j+1..markerSize-1].include? marker[j] then
      isMarker = false
    end
  end

  if isMarker then
    isMessage = true
    message = input[i..i+messageSize-1]
    if !hasShownMarker then
      puts i+markerSize
      hasShownMarker = true
    end
    for j in 0..messageSize-1
      if message[j+1..messageSize-1].include? message[j] then
        isMessage = false
      end
    end
  end

  if isMessage then
    puts i+messageSize
    break
  end
end

file.close