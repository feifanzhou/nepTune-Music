def rand_case str
  res = ''
  str.size.times do |i|
    res << str[i].chr.send(rand >= 0.5 ? :upcase : :downcase)
  end
  res
end
