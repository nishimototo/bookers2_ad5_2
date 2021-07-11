class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @users = Users.looks(params[:word], params[:search])
    else
      @books = Books.looks(params[:word], params[:search])
    end
  end
end
