require_relative 'lisp'

program = "(begin (define r 10) (* pi (* r r)))"
puts tokenize(program) == ['(', 'begin', '(', 'define', 'r', '10', ')', '(', '*', 'pi', '(', '*', 'r', 'r', ')', ')', ')']
puts parse(program) == [:begin, [:define, :r, 10], [:*, :pi, [:*, :r, :r]]]
puts eval(parse("(+ 3 5)")) == 8
puts eval(parse("(+ 3 5 8)")) == 16
puts eval(parse("(* 3 5 8)")) == 120
puts eval(parse("(- 3 5)")) == -2
puts eval(parse("(/ 6 2)")) == 3
eval(parse("(define pi 3.14)"))
eval(parse("(define circle-area (lambda (r) (* pi (* r r))))"))
puts eval(parse("(circle-area 10)")) == 314
eval parse "(define make-account (lambda (balance) (lambda (amt) (begin (set! balance (+ balance amt)) balance))))"
eval parse "(define account1 (make-account 100))"
puts 120 == eval(parse "(account1 20)")
puts 0.0 == eval(parse "(sin 0)")
puts 2.0 == eval(parse "(log 4 2)")