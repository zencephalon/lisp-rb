class Env
  def self.global
    env = {}
    [:+, :*].each do |op|
      env[op] = lambda {|*args| args.reduce(op)}
    end
    [:-, :/].each do |op|
      env[op] = lambda {|a, b| a.send(op, b)}
    end
    new(env, nil)
  end

  def initialize(hash, parent)
    @hash, @parent = hash, parent
  end

  def [](var)
    @hash[var]
  end

  def find(var)
    if @hash.include? var
      @hash
    else
      @parent.find(var) if @parent
    end
  end
end