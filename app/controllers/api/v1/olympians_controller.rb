class Api::V1::OlympiansController < ApplicationController
  def index
    render json: {
      "olympians": FormatOlympians.all_olympians
    }
  end
end
