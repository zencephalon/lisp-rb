class Env
  def self.global
    env = {}
    [:+, :*].each do |op|
      env[op] = lambda {|*args| args.reduce(op)}
    end
    [:-, :/, :>, :<, :<=, :>=].each do |op|
      env[op] = lambda {|a, b| a.send(op, b)}
    end
    Math.methods(false).each do |sym|
      env[sym] = lambda {|*args| Math.send(sym, *args)}
    end
    env[:abs] = lambda {|n| n.abs}
    env[:begin] = lambda {|*args| args[-1]}
    new(env, nil)
  end

  def initialize(hash, parent)
    @hash, @parent = hash, parent
  end

  def [](var)
    @hash[var]
  end

  def []=(var, val)
    @hash[var] = val
  end

  def find(var)
    if @hash.include? var
      @hash
    else
      @parent.find(var) if @parent
    end
  end

  def child(params, args)
    self.class.new(Hash[params.zip(args)], self)
  end
end