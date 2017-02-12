require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "#index" do
    it "shows the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    it "shows the new form page" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    it "create new gram in the database" do
      post :create, gram: {message: 'Hello!'}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      end
  end
end
