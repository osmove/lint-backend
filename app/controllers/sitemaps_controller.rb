class SitemapsController < ApplicationController
  layout false

  def show
    respond_to do |format|
      format.xml
    end
  end
end
