require_relative 'env'

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

GLOBAL_ENV = Env.global

def eval(exp, env = GLOBAL_ENV)
  if exp.is_a?(Symbol)
    puts "looking for: #{exp}"
    p env
    val = env.find(exp)[exp]
    puts "value: #{exp}, #{val}"
    val
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
      p exp
      var, exp = exp
      env[var] = eval(exp, env)
    elsif :'set!' == fun
      var, exp = exp
      env.find(var)[var] = eval(exp, env)
    elsif :lambda == fun
      params, body = exp
      proc = Procedure.new(params, body, env)
      p proc
      proc
    else
      proc = eval(fun, env)
      p "Got to proc call"
      p proc
      args = exp.map {|arg| eval(arg, env)}
      proc.call(*args)
    end
  end
end


class Procedure
  def initialize(params, body, env)
    @params, @body, @env = params, body, env
  end
  def call(*args)
    puts "PROC CALL =========="
    p @params.zip(args)
    p Hash[@params.zip(args)]
    return eval(@body, @env.child(@params, args))
  end
end