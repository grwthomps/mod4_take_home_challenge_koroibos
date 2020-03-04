class Api::V1::EventsController < ApplicationController
  def index
    render json: {
      "events": FormatEvents.all_events
    }
  end
end
