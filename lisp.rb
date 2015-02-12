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

def atom(token)
  begin
    return Integer(token)
  rescue
    begin
      return Float(token)
    rescue
      return token.to_sym
    end
  end
end

def parse(program)
  read_from_tokens tokenize program
end

def eval(exp, env = GLOBAL_ENV)
  if exp.is_a?(Symbol)
    env[exp]
  elsif ! exp.is_a?(Array)
    exp
  else
    fun, *exp = exp
    if :quote == fun
      exp
    elsif :if == fun
      test, conseq, alt = exp
      exp = eval(test, env) ? conseq : alt
      eval(exp, env)
    elsif :define == fun
      var, *exp = exp
      env[var] = eval(exp, env)
    else
      proc = eval(fun, env)
      args = exp.map {|arg| eval(arg, env)}
      proc.call(*args)
    end
  end
end