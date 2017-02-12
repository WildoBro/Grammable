require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "#edit" do
    it "shows page when valid ID is passed" do
      gram = FactoryGirl.create(:gram)
      get :edit, id: gram.id
      expect(response).to have_http_status(:success)
    end

    it "return 404 error when invalid ID is passed" do
      get :edit, id: 'TACOCAT'
      expect(response).to have_http_status(:not_found)
    end
  end


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

  describe "#update" do
    it "allows updates to grams" do
      gram = FactoryGirl.create(:gram, message: "Initial Value")
      patch :update, id: gram.id, gram: {message: "Changed!"}
      expect(response).to redirect_to root_path
      gram.reload
      expect(gram.message).to eq "Changed!"
    end

    it "return 404 error when invalid ID is passed" do
      patch :update, id: "YOLOSWAG", gram: {message: 'Changed'}
      expect(response).to have_http_status(:not_found)
    end

    it "shows edit form with status of unprocessable_entity" do
      gram = FactoryGirl.create(:gram, message: "Initial Value")
      patch :update, id: gram.id, gram: {message: ' '}
      expect(response).to have_http_status(:unprocessable_entity)
      gram.reload
      expect(gram.message).to eq "Initial Value"
    end
  end

  describe "#destroy" do
    it "can delete grams" do 
      gram = FactoryGirl.create(:gram)
      delete :destroy, id: gram.id
      expect(response).to redirect_to root_path
      gram = Gram.find_by_id(gram.id)
      expect(gram).to eq nil
    end

    it "return 404 error when invalid ID is passed" do 
      delete :destroy, id: 'SPACEDUCK'
      expect(response).to have_http_status(:not_found)
    end
  end

end
