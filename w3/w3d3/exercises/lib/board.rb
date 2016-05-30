#!/usr/bin/env ruby

# -------------------------------------------------------
# board.rb - Lizzi Sparks - May 2016
#
# Part of the w3d3 Battleships game. See './battleship.rb'
# for more details.
#
# `Board` class: controls the Battleships game board.
# Global constants:
# - `Board::SHIPS` : hash whose `keys` are strings containing
# the names of the canonical Battleships ships and whose
# `values` are arrays whose zeroth entry is an integer
# representing ship size and whose first entry is a symbol
# to be used during gameplay.
# N.B. conveniently, one of these ships is a submarine with
# symbol `:s`. `:s` is the same symbol used to represent a
# generic "ship" in the specs, so they and my expanded
# game coexist nicely ;)
#
# - `Board::SYMBOLS` : an array containing the ship symbols.
# Some methods I needed ship size, name, symbol, and the
# entire `SHIPS` hash was useful, but I found myself needing
# just the symbols at other times, i.e. counting # of ships.
#
# Methods:
# - `Board::default_grid` : returns a 10 x 10 array populated
# with `nil`s.
# - `Board#initialize(opt'l Array)` : if `Array` given,
# assigns it to class attribute `@grid`, else creates a new
# array for `@grid` by calling `::default_grid` above. Also
# defines `@grid_height` and `@grid_width` from `@grid` for
# use in the various helper methods of the `Board` class. Last,
# sets up a `@grid_player_sees` class attribute, which begins
# empty and will be populated with `:~`es (empty ocean -- a
# miss) and `:x`es (destroyed ships -- a hit) during gameplay.
#
# - `Board#count(opt'l Symbol)` : returns the number of ships
# of type `Symbol` currently on the board. If no optional arg
# specified, returns total number of all ships.
#
# - `Board#[](Array)` : a nice shortcut with some syntatic
# sugar for `Board.grid[Array[0]][Array[1]]` -> `Board[Array]`.
#
# - `Board#[]=(Array, Symbol)` : as above, makes entering
# `Board.grid[Array[0]][Array[1]] = Symbol`
#                                   -> `Board[Array] = Symbol`.
#
# - `Board#won?` : returns `true` if there are no ships on the
# board (calls `Board#empty?` below with no arguments).
#
# - `Board#empty?(opt'l Array)` : if no array given, returns
# `true` if no ships are found on the board. If `Array` given,
# returns `true` if the grid at the indices specifed in `Array`
# contains `nil`.
#
# - `Board#place_random_ship` : calls `#random_index` below and
# if that index does not already contain a ship (simply re-calls
# `#random_index` if so until no conflict) places a ship there.
# Note that this method is not used during gameplay because in
# order to place the multi-index ships, a lot more work has to be
# done to avoid placing ships on top of one another, so it's only
# here to let the specs pass. But it was definitely a helpful
# jumping off point when first starting with this game!
#
# - `Board#full?` : returns `true` if there are no `nil`s in the
# grid. Again, this is one of those spec-passing methods that
# never gets called during gameplay/setup.
#
# - `Board#random_index(opt'l Integer1, opt'l Integer2)` : returns
# a 2-integer array representing an index in the grid. The optional
# arguments are used by `#populate_grid` below to make sure that
# when that method is calling `#random_index` for a starting index
# for a multi-symbol ship, it does not consider locations that would
# put the rest of the ship out of board range (i.e. a horizontally-
# oriented Battleship of size 4 cannot start at [9,9] on the grid).
#
# - `Board#in_range?(Array)` : returns `true` if `Array`'s first
# indices are located in `@grid`'s index range. As with a few of
# the other methods above, this is a spec-passing method only. The
# logic for making sure that the multi-index ships used during
# gameplay are in range happens in `#random_index()` above.
# 
# - `Board#populate_grid` : places one of each ship in `SHIPS`
# on the grid, choosing randomly whether a given ship will be
# oriented vertically or horizontally on the board. When finding
# a suitable location for each ship, calls `#no_conflict?()` below
# to ensure that it would not overwrite any previously-placed ships.
#
# - `Board#no_conflict?(options hash)` : returns `true` if all
# locations on the board from ship's start index (given in options
# hash as `[:start]`) that the ship would be place in (determined by
# value of `[:size]` passed in options hash) across columns if ship
# is oriented vertically or rows if horizontal are clear of any
# previously set ships (i.e. every index inspected must contain `nil`).
#
# - `Board#place_ship(options hash)` : assigns the symbol passed in
# options hash under `[:sym]` to the number of indices determined by
# `[:size]`, starting at `[:start]` and increasing by row if ship is
# oriented vertically (`:orient => "v"`) or column if horizontal.
#
# - `Board#mark_display_grid(position Array, Sym)` : serves the
# same purpose as `Board#[]=(Array, Sym)` above, but for the grid
# that shown during gameplay, `@grid_player_sees`. It's not as
# pretty as `#[]=` but unfortunately that trick doesn't work twice
# in one class. Still a whole lot nicer than
#                  `board.grid_player_sees[pos[0]][pos[1]]` though!
#
# - `Board#ship_type(Symbol)` : returns the name of a ship in
# `Board::SHIPS` that matches `Symbol`.
#
# - `Board#display(Array)` : prints a nice ASCII representation
# of the current state of play. During gameplay, input array is only
# ever `@grid_player_sees` but I also used this a TON when debugging as
# it was a huge headache saver if passed `@grid` (vs printing the grid,
# which was never aligned well enough to tell which ships were where) :)
#
# - `Board#grid_header(grid_width)` : helper method for `#display()`
# above. Prints the grid's column numbers in a line.
#
# - `Board#grid_separator(grid_width)` : helper method for
# `#display()` above. Prints a line of dashes of length `@grid_width`.
#
# - `Board#print_row(grid, Integer)` : helper method for
# `#display()` above. Where the magic happens! Prints the row index
# number followed by the symbol located at each column of that row,
# separated by pipes.
#
# -------------------------------------------------------

class Board
  SHIPS = {
    "Aircraft Carrier" => [5, :a],
    "Battleship"       => [4, :b],
    "Submarine"        => [3, :s],
    "Destroyer"        => [3, :d],
    "Patrol Boat"      => [2, :p]
  }

  SYMBOLS = SHIPS.values.flatten.select { |v| v.is_a?(Symbol) }

  attr_reader :grid, :grid_player_sees, :grid_width, :grid_height
  
  def self.default_grid
    grid = []
    10.times { grid << Array.new(10, nil) }

    grid
  end
  
  def initialize(grid = nil)
    case grid
    when Array then @grid = grid
    else @grid = Board::default_grid
    end
    
    @grid_width = @grid.first.length
    @grid_height = @grid.length

    @grid_player_sees = []
    @grid_height.times { @grid_player_sees << Array.new(@grid_width, " ") }
  end

  def count(ship_sym = :all_ships)
    count = 0

    case ship_sym
    when :all_ships
      @grid.each { |row| count += row.select{ |sym| SYMBOLS.include?(sym) }.size }
    else
      @grid.each { |row| count += row.select{ |sym| sym == ship_sym }.size }
    end

    count
  end
  
  def [](pos)
    row, col = pos
    @grid[row][col]
  end
  
  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end
  
  def won?
    empty?
  end

  def empty?(pos = [])
    if pos.empty?
      @grid.flatten.none? { |sym| SYMBOLS.include?(sym) }
    else
      self[pos].nil?
    end
  end

  def place_random_ship
    raise if full?

    rand_pos = random_index
    rand_pos = random_index until empty?(rand_pos)

    self[rand_pos] = :s
  end

  def full?
    @grid.flatten.none? &:nil?
  end

  def random_index(row_minus = 0, col_minus = 0)
    row_max = @grid_height - row_minus
    col_max = @grid_width - col_minus

    [rand(0...row_max), rand(0...col_max)]
  end

  def in_range?(pos)
    row, col = pos
    row_range = 0...@grid_height
    col_range = 0...@grid_width

    row_range.include?(row) && col_range.include?(col)
  end

  def populate_grid
    SHIPS.each_value do |ship_attributes|
      ship = {}
      ship[:size], ship[:sym] = ship_attributes
      
      ship[:orient] = ["v","h"].sample
      case ship[:orient]
      when "v"
        row_minus = ship[:size] - 1
        col_minus = 0
      when "h"
        row_minus = 0
        col_minus = ship[:size] - 1
      end

      ship[:start] = random_index(row_minus, col_minus)
      ship[:start] = random_index(row_minus, col_minus) until no_conflict?(ship)

      place_ship(ship)
    end

  end

  def no_conflict?(ship)
    test_row, test_col = ship[:start]

    case ship[:orient]
    when "v"
      row_range = test_row...test_row + ship[:size]

      row_range.all? { |row| self[[row, test_col]].nil? }
    when "h"
      col_range = test_col...test_col + ship[:size]

      col_range.all? { |col| self[[test_row, col]].nil? }
    end
  end

  def place_ship(ship)
    ship[:size].times do |count|
      row, col = ship[:start]

      case ship[:orient]
      when "v" then row += count
      when "h" then col += count
      end
      pos = row, col

      self[pos] = ship[:sym]
    end
  end

  def mark_display_grid(pos, sym)
    row, col = pos
    @grid_player_sees[row][col] = sym
  end

  def ship_type(sym)
    SHIPS.each do |ship_name, ship_attributes|
      _, ship_sym = ship_attributes
      return ship_name if sym == ship_sym
    end
  end

  def display(grid)
    grid_header(grid_width)
    grid_separator(grid_width)
    grid.each_index do |row_index|
      print_row(grid, row_index)
      grid_separator(grid_width)
    end
  end

  def grid_header(grid_width)
    print "  "
    grid_width.times { |col_number| print "  #{col_number} " }
    print "\n"
  end

  def grid_separator(grid_width)
    print "  "
    grid_width.times { print "----" }
    print "\n"
  end

  def print_row(grid, row_index)
    print "#{row_index} | "
    grid[row_index].each { |sym| print %(#{sym.to_s} | ) }
    print "\n"
  end
end
