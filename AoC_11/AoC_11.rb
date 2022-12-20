require 'json'

def getMonkeyBusiness (part)
  file = File.open("./input")
  input = file.read.split("\n")
  i=0
  monkeys=[]

  # read monkeys mind
  while(input[i]!=nil)
    monkey={}
    monkey["items"] = input[i+1].split(': ')[1].split(', ').map { |elt| elt.to_i }
    monkey["operation"] = input[i+2].split('= ')[1]
    monkey["test"] = input[i+3].split('divisible by ')[1].to_i
    monkey["true"] = input[i+4].split('throw to monkey ')[1].to_i
    monkey["false"] = input[i+5].split('throw to monkey ')[1].to_i
    monkey["nb_inspection"] = 0

    monkeys.push(monkey)
    i+=7
  end

  rounds = part == 1 ? 20 : 10000
  # in part 2 worry level will start getting waaaaay too big, use the chinese remainder theorem, we first need the ppcm of all monkeys test
  # (had to search the internet to find that chinese math trick ^^')
  ppcm=monkeys.collect { |monkey| monkey["test"] }.reduce(1, :*)

  # starts rounds
  for j in 1..rounds do
    for k in 0..monkeys.length-1 do
      monkey = monkeys[k]
      if monkey["items"].length == 0 then
        next
      end

      # throw items
      for l in 0..monkey["items"].length-1 do
        item = monkey["items"].shift()
        monkey["nb_inspection"]+= 1
        old = item
        # inspect (operation) ouch eval...
        item = eval(monkey["operation"])

        # change worry level according to part..
        if part == 1 then
          item = (item/3).to_i
        elsif part == 2 then
          item = item%ppcm
        end

        # test worry level (test)
        # choose target monkey (true/false)
        if (item%monkey["test"] == 0) then
          monkeys[monkey["true"]]["items"].push(item)
        else
          monkeys[monkey["false"]]["items"].push(item)
        end
      end

    end
  end

  sortedMonkeys = monkeys.sort_by {|monkey| -monkey["nb_inspection"]}
  monkeyBusiness = sortedMonkeys[0]["nb_inspection"] * sortedMonkeys[1]["nb_inspection"]

  return monkeyBusiness
end

puts getMonkeyBusiness 1
puts getMonkeyBusiness 2
