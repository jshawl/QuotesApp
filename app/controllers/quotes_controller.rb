class QuotesController < ApplicationController

  def index
    if params[:author_id]
      @author = Author.find(params[:author_id])
      @quotes = Quote.all.where(author_id:@author.id)
    elsif params[:collection_id]
      @collection = Collection.find(params[:collection_id])
      @quotes = @collection.quotes
      render 'collection_index' # can this be just index.html.erb? i.e. reuse your index view
      # also I'm looking at config routes and thinking this block could be moved to collection controller
      # show page
    else
      @quotes = Quote.all
      render 'no_author_index'
    end
  end

  def show
    @quote=Quote.find(params[:id])
    if @quote.author
      render 'show'
    else
      render 'no_author_show' # recommend moving this to conditional in view
    end
  end

  def new
    if params[:author_id]
      @quote=Quote.new
    else
      @quote=Quote.new
      render 'no_author_new' # same as above
    end
  end

  def edit
    @quote=Quote.find(params[:id])
  end

  def create
    if params[:author_id]
      @author = Author.find(params[:author_id])
      @quote = @author.quotes.new(quote_params)
      # aboe three lines are not necessary if submitting rails' `form_for`
    elsif params[:quote][:author_id]
      if Author.find_by(name:params[:quote][:author_id])
        @author=Author.find_by(name:params[:quote][:author_id])
        @quote=@author.quotes.create(content:params[:quote][:content])
      else
        @author=Author.create(name:params[:quote][:author_id])
        @quote = @author.quotes.new(content:params[:quote][:content])
      end
    else
      @quote = Quote.new(quote_params)
    end

    # check out find_or_create_by
    # http://apidock.com/rails/v4.0.2/ActiveRecord/Relation/find_or_create_by
    # Also, you can move this logic to your quote model. More comments there

    if @quote.save
      redirect_to quote_path(@quote)
    else
      render 'new'
    end

  end

  def update
    @quote = Quote.find(params[:id])
    @author = @quote.author

    if @quote.update(quote_params)
      redirect_to quote_path
    else
      render 'edit'
    end

  end

  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy
    if params[:author_id]
      redirect_to author_quotes_path
    else
      redirect_to quotes_path
    end
  end

  private
    def quote_params
      params.require(:quote).permit(:content, :auteur, :source, :year, :author_id)
    end

end
