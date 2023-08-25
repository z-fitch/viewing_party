require 'rails_helper'

RSpec.describe Actor do
  it 'exists' do
    attributes = {
      character: 'Elle Woods',
      name: 'Reese Witherspoon'
    }

    actor = Actor.new(attributes)

    expect(actor).to be_a(Actor)
    expect(actor.character).to eq('Elle Woods')
    expect(actor.name).to eq('Reese Witherspoon')
  end
end
