class ListsController < ApplicationController
  respond_to :html, :json

  before_action :set_list, only: %i(update destroy)

  def index
    @lists = current_user.lists
  end

  def create
    @list = current_user.lists.create(list_params)
  end

  def update
    @list.update(list_params)
  end

  def destroy
    @list.destroy
  end

  private 

    def list_params
      params.require(:list).permit :title
    end

    def set_list
      @list = List.find(params[:id])
    end

end
