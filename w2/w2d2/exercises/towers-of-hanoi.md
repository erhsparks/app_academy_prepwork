# Towers of Hanoi

Write a
[Towers of Hanoi](http://en.wikipedia.org/wiki/Towers_of_hanoi) game.

In a class `TowersOfHanoi`, keep an array of three arrays. Each subarray should 
represent a tower. Each tower should store integers representing the size of its 
discs. 

You'll want a `#play` method. In a loop, prompt the user using puts. Ask what 
pile to select a disc from. Use 
gets([gets](http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/)) to 
get an answer. Similarly, find out which pile the user wants to move the disc 
to. Next, you'll want to do different things depending on whether or not the 
move is valid. Finally, if they have succeeded in moving all of the discs to 
another pile, they win! The loop should end.

You'll want a `TowersOfHanoi#render` method. Don't spend too much time on this, 
just get it playable.

Think about what other helper methods you might want. Here's a list of all the
instance methods I had in my TowersOfHanoi class:
** initialize
** play
** render
** won?
** valid_move?
** move

Make sure that the game works in the console. There are also some specs to keep 
you on the right track (make sure you run `bundle install` first!):

```bash
bundle exec rspec spec/towers_of_hanoi_spec.rb
```

