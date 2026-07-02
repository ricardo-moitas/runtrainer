class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def dashboard
    @runs = current_user.runs.order(date: :desc)
  end
end
