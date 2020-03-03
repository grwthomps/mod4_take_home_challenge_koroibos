class Api::V1::OlympiansController < ApplicationController
  def index
    render json: {
      "olympians": FormatOlympians.result(params["age"])
    }
  end
end
