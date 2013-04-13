class PublicController < ApplicationController
   skip_before_filter :authenticate_user!
  def index
  end

  def tos

  end

  def nyc
  end
end
