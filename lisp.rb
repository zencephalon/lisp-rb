def parse(str)
  str.gsub('(', ' ( ').gsub(')', ' ) ').split(' ')
end