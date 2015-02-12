require_relative 'lisp'

puts tokenize("(begin (define r 10) (* pi (* r r)))") == ['(', 'begin', '(', 'define', 'r', '10', ')', '(', '*', 'pi', '(', '*', 'r', 'r', ')', ')', ')']