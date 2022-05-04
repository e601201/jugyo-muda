class ApplicationController < ActionController::Base
  before_action :set_data


  def set_data
    @week = ["mon",
             "tue",
             "wed",
             "thu",
             "fri",
             "sat",
             "sun"]
    @persons = ["a","b","c"]
  end
end
