class TowersOfHanoi
  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def play
    render

    until won?
      puts 'What tower do you want to move from?'
      from_tower = gets.to_i

      puts 'What tower do you want to move to?'
      to_tower = gets.to_i

      if valid_move?(from_tower, to_tower)
        move(from_tower, to_tower)
        render
      else
        render
        puts "Invalid move. Try again."
      end
    end

    puts 'You win!'
  end

  def won?
    @towers[0].empty? && (@towers[1].empty? || @towers[2].empty?)
  end

  def valid_move?(from_tower, to_tower)
    return false unless [from_tower, to_tower].all? { |i| i.between?(0, 2) }

    !@towers[from_tower].empty? && (
      @towers[to_tower].empty? || 
      @towers[to_tower].last > @towers[from_tower].last
    )
  end

  def move(from_tower, to_tower)
    @towers[to_tower] << @towers[from_tower].pop
  end

  def render
    system('clear')
    puts 'Tower 0:  ' + @towers[0].join('  ')
    puts 'Tower 1:  ' + @towers[1].join('  ')
    puts 'Tower 2:  ' + @towers[2].join('  ')
    puts
  end
end

if $PROGRAM_NAME == __FILE__
  TowersOfHanoi.new().play
end
