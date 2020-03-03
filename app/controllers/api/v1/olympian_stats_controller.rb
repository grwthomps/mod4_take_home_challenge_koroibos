class Api::V1::OlympianStatsController < ApplicationController
  def index
    render json: {
      "olympian_stats": FormatOlympianStats.all_stats
    }
  end
end
