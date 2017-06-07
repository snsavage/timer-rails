class Api::V1::TestController < ApplicationController
  def index
    respond_with JSON.parse('{"hello": "goodbye"}')
  end
end
