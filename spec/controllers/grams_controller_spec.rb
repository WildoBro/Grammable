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
      user = User.create(
        email:                    'fakeuseremail@gmail.com',
        password:                 'securePassword',
        password_confirmation:    'securePassword'
      )
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
      user = User.create(
        email:                    'fakeuseremail@gmail.com',
        password:                 'securePassword',
        password_confirmation:    'securePassword'
      )
      sign_in user
      
      post :create, gram: {message: 'Hello!'}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
      end

    it "validates entries" do
      user = User.create(
        email:                    'fakeuseremail@gmail.com',
        password:                 'securePassword',
        password_confirmation:    'securePassword'
      )
      sign_in user

      post :create, gram: {message: ' '}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end
  end
end
