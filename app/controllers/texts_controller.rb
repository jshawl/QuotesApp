class TextsController < ApplicationController
  # hidden feature? Recommend moving to a feature branch / deleting

  def index
    @texts = Text.all
  end

  def create
    @text = Text.new(text_params)

    if @text.save
      redirect_to @text
    else
      render 'new'
    end
  end

  def show
    @text = Text.find(params[:id])
  end

  def new
    @text = Text.new
  end

  private
    def text_params
      params.require(:text).permit(:body)
    end

end
