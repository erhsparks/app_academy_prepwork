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

  # We only need to shuffle one component for the new combinations to be random.
  mixers.shuffle!

  new_drinks = []
  alcohols.each_index do |i|
    new_drinks << [alcohols[i], mixers[i]]
  end
  new_drinks
end

# Bonus solution; with this approach, we re-shuffle if any of the new
# drinks were in the original set.
def remix(drinks)
  new_drinks = drinks

  until new_drinks.none? { |drink| drinks.include?(drink) }
    new_drinks = remix_helper(drinks)
  end

  new_drinks
end

def remix_helper(drinks)
  # Does the same thing as the original `remix` solution above
  alcohols = drinks.map(&:first)
  mixers = drinks.map(&:last)

  alcohols.zip(mixers.shuffle)
end
