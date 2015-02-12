# Convert a string into an array of tokens
def tokenize(str)
  str.gsub('(', ' ( ').gsub(')', ' ) ').split(' ')
end

# Read an expression from an array of tokens
def read_from_tokens(tokens)
  raise SyntaxError, 'unexpected EOF while reading' if tokens.size == 0
  token = tokens.shift
  if '(' == token
    sexp = []
    sexp.push(read_from_tokens(tokens)) while tokens.first != ')'
    tokens.shift # remove the ')'
    return sexp
  elsif ')' == token
    raise SyntaxError, 'unexpected )'
  else
    return atom(token)
  end
end

def parse(program)
  read_from_tokens tokenize program
end