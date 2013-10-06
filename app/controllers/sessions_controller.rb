class SessionsController < ApplicationController
  def new
  end

  def create
    session[:username] = params[:username]
    render :text => "Welcome #{session[:username]}!"
  end
end
