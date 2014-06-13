class ThingsController < ApplicationController
  respond_to :html, :json

  before_action :set_thing, only: %i(update destroy finish unfinish)

  def index
    @things = current_user.things.unfinished
  end

  def create
    @thing = current_user.things.create(thing_params)
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

  private 

    def thing_params
      params.require(:thing).permit :description
    end

    def set_thing
      @thing = Thing.find(params[:id])
    end
end
