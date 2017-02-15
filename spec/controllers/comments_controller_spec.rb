require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "#create" do
    it "allows creation on comments" do 
      gram = FactoryGirl.create(:gram)

      user = FactoryGirl.create(:user)
      sign_in user

      post :create, gram_id: gram_id, comment: { message: 'awesome gram' }
      expect(reponse).to redirect_to root_path
      expect(gram.comments.length).to eq 1
      expect(gram.comments.first.message).to eq "awesome gram"
    end

    it "require a logged in user to comment" do 
      gram = FactoryGirl.create(:gram)
      post :create, gram_id: gram.id, comment: { message: 'awesome gram'}
      expect(response).to redirect_to new_user_session_path
    end

    it "return 404 error when invalid ID is passed" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, gram_id: 'phoney', comment: { message: 'awesome gram'}
      expect(response).to have_http_status :not_found
    end
  
  end
end
