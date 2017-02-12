class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def index
  end

  def new
    @gram = Gram.new
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    render_if_blank if @gram.blank?    
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    render_if_blank if @gram.blank?
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_if_blank if @gram.blank?
    @gram.update_attributes(gram_params)

    if @gram.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end

  def render_if_blank
    render text: 'Not Found :(', status: :not_found
  end
  
end
