require_relative 'lisp'

program = "(begin (define r 10) (* pi (* r r)))"
puts tokenize(program) == ['(', 'begin', '(', 'define', 'r', '10', ')', '(', '*', 'pi', '(', '*', 'r', 'r', ')', ')', ')']
puts parse(program) == [:begin, [:define, :r, 10], [:*, :pi, [:*, :r, :r]]]
puts eval(parse("(+ 3 5)")) == 8
puts eval(parse("(+ 3 5 8)")) == 16
puts eval(parse("(* 3 5 8)")) == 120
puts eval(parse("(- 3 5)")) == -2
puts eval(parse("(/ 6 2)")) == 3