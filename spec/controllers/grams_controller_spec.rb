require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "#index" do
    it "shows the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    it "requires a logged in user" do 
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "shows the new form page" do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    it "requires a logged in user" do 
      get :create, gram: {message: 'Hello!'}
      expect(response).to redirect_to new_user_session_path
    end

    it "create new gram in the database" do
      user = FactoryGirl.create(:user)
      sign_in user
      
      post :create, gram: {message: 'Hello!'}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
      end

    it "validates entries" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, gram: {message: ' '}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end
  end

  describe "#show" do 
    it "shows page when valid ID is passed" do
      gram = FactoryGirl.create(:gram)
      get :show, id: gram.id
      expect(response).to have_http_status(:success)
    end

    it "return 404 error when invalid ID is passed" do
      get :show, id: 'TACOCAT'
      expect(response).to have_http_status(:not_found)
    end
  end

end
