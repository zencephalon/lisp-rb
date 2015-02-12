require_relative 'lisp'

puts parse("(begin (define r 10) (* pi (* r r)))") == ['(', 'begin', '(', 'define', 'r', '10', ')', '(', '*', 'pi', '(', '*', 'r', 'r', ')', ')', ')']