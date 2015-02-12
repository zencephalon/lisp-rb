# Convert a string into an array of tokens
def tokenize(str)
  str.gsub('(', ' ( ').gsub(')', ' ) ').split(' ')
end

# Read an expression from an array of tokens
def read_from_tokens(tokens)
  raise SyntaxError, 'unexpected EOF while reading' if tokens.size == 0
  token = tokens.pop
  if '(' == token
    sexp = []
    sexp.concat(read_from_tokens(tokens)) while tokens.first != ')'
    tokens.pop # remove the ')'
  elsif ')' == token
    raise SyntaxError, 'unexpected )'
  else
    return atom(token)
  end
end
