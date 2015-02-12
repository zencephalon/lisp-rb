def tokenize(str)
  str.gsub('(', ' ( ').gsub(')', ' ) ').split(' ')
end