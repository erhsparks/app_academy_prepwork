def guessing_game
  num = rand(100) + 1
  num_guesses = 0
  loop do
    puts "Guess a number between 1 and 100"
    guess = gets.to_i
    num_guesses += 1
    if guess == num
      break
    elsif guess < num
      puts "#{guess} is too low. Try again."
    else
      puts "#{guess} is too high. Try again."
    end
  end

  puts "You won in #{num_guesses} guesses! The number was #{num}!"
end
