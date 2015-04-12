class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @request = Api.new(params[:sessions][:username], params[:sessions][:password])
    @request.post("authentication")
    if(!@request)
      flash.now[:alert] = "Lets try again"
      render action: "new"
    else
      log_in
      redirect_to root_path
    end
  end
end
