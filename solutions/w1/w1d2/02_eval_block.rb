def eval_block(*args, &prc)
  if prc.nil?
    puts "NO BLOCK GIVEN!"
  else
    prc.call(*args)
  end
end
