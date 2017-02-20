require 'rails_helper'

RSpec.describe Comment, type: :model do

  it "requires a user to be set" do
    comment = Comment.new
    expect(comment).to_not be_valid
    expect(comment.errors.keys).to include :user_id
  end

  it "requires a gram to be set" do
    comment = Comment.new
    expect(comment).to_not be_valid
    expect(comment.errors.keys).to include :gram_id
  end

  it "requires a message to be set" do
    comment = Comment.new
    expect(comment).to_not be_valid
    expect(comment.errors.keys).to include :message
  end
  
end
