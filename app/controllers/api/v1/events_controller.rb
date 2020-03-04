class Api::V1::EventsController < ApplicationController
  def index
    render json: {
      "events": FormatEvents.all_events
    }
  end

  def show
    render json: FormatEvents.by_medalists(params["id"])
  end
end
