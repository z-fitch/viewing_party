class Actor
  attr_reader :character, :name

  def initialize(actor_data)
    @character = actor_data[:character]
    @name = actor_data[:name]
  end
end