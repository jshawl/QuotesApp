class CollectionsController < ApplicationController
  # can use a before action to set the collection instance variable

  def index
    @collections = Collection.all
  end

  def new
    @collection = Collection.new
  end

  def show
    @collection = Collection.find(params[:id])
    @quotes = @collection.quotes
  end

  def create
    @collection = Collection.new(collection_params)
    # @collection = Collection.new(collection_params.merge(user: current_user))

    if @collection.save
      redirect_to collection_path(@collection)
    else
      render 'new'
    end
  end

  def edit
    @collection = Collection.find(params[:id])
    @quotes = @collection.quotes
  end

  def update
    @collection = Collection.find(params[:id])

    if @collection.update(collection_params)
      redirect_to @collection
    else
      render 'edit'
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    # if you associate a user w/ collection you can restrict who deletes
    # if @collection.user == current_user
    @collection.destroy
    redirect_to collections_path
  end

  private
    def collection_params
      params.require(:collection).permit(:title)
    end

end
