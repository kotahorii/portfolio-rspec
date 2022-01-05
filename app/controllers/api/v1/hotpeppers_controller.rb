class Api::V1::HotpeppersController < ApplicationController
  require 'httpclient'

  def index
    base_url = ENV['SECRET_KEY'].to_s + params[:key]
    client = HTTPClient.new
    response = client.get(base_url)
    json = JSON.parse(response.body)
    puts response.status
    puts response.body
    render status: 200, json: json
  end
end
