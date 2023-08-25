class Review
  attr_reader :author, :content 

  def initialize(review_info)
    @author = review_info[:author]
    @content = review_info[:content]
  end
end