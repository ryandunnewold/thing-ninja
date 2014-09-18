class ThingsController < ApplicationController
  respond_to :html, :json

  before_action :set_list, only: %i(index procrastinated create)
  before_action :set_thing, only: %i(update destroy finish unfinish procrastinate unprocrastinate)  

  def index
    if @list 
      @things = @list.things.today
    else
      @things = current_user.things.today
    end
  end

  def procrastinated
    if @list 
      @procrastinated_things = @list.things.procrastinated
    else
      @procrastinated_things = current_user.things.procrastinated
    end
  end

  def create
    if @list
      @thing = @list.things.create(thing_params)
    else
      @thing = current_user.things.create(thing_params)
    end
  end

  def update
    @thing.update(thing_params)
  end

  def destroy
    @thing.destroy
  end

  def finish
    @thing.update(finished: true, finished_at: Time.now)
  end

  def unfinish
    @thing.update(finished: false, finished_at: nil)
  end

  def procrastinate
    @thing.update(date: Date.today.tomorrow)
  end

  def unprocrastinate
    @thing.update(date: Date.today)
  end

  private 

    def thing_params
      params.require(:thing).permit :description
    end

    def set_list
      @list = List.find(params[:list_id]) if params[:list_id]
    end

    def set_thing
      @thing = Thing.find(params[:id])
    end

end
