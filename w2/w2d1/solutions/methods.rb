def rps(choice)
  choices = ["Rock", "Paper", "Scissors"]

  unless choices.include?(choice)
    puts "Invalid choice!"
    return
  end

  computer_choice = choices.sample

  if choice == computer_choice
    return "#{computer_choice}, Draw"
  end

  wins = [
    ["Rock", "Scissors"],
    ["Paper", "Rock"],
    ["Scissors", "Paper"]
  ]

  if wins.include?([choice, computer_choice])
    "#{computer_choice}, Win"
  else
    "#{computer_choice}, Lose"
  end
end

# alternative solution for rps

def outcome(choice, computer_choice)
  condition = [choice.downcase, computer_choice]
  pairs = [["rock", "scissors"], ["scissors", "paper"], ["paper", "rock"]]

  if pairs.include?(condition)
    "Win"
  elsif pairs.include?(condition.reverse)
    "Lose"
  else
    "Draw"
  end
end

def rps(choice)
  rps_choices = ["rock", "paper", "scissors"]
  comp_choice = rps_choices.sample

  "#{comp_choice.capitalize}, #{outcome(choice, comp_choice)}"
end


def remix(drinks)
  alcohols = drinks.map(&:first)
  mixers = drinks.map(&:last)

  alcohols.shuffle!
  mixers.shuffle!

  new_drinks = []
  alcohols.each_index do |i|
    new_drinks << [alcohols[i], mixers[i]]
  end
  new_drinks
end
