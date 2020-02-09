class ExamplesController < ApplicationController
  def index
    raise "nope"
    render json: []
  end
end
