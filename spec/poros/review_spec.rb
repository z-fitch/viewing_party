require 'rails_helper'

RSpec.describe Review do
  it 'exists' do
    attributes = {
      author: 'Elle Woods',
      content: 'Whoever said orange is the new pink was seriously disturbed.'
    }

    review = Review.new(attributes)

    expect(review).to be_a(Review)
    expect(review.author).to eq('Elle Woods')
    expect(review.content).to eq('Whoever said orange is the new pink was seriously disturbed.')
  end
end
