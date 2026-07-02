class ChatsController < ApplicationController
  def chat
    @run = Run.find(params[:id])
    @history = current_user.runs.order(date: :desc)
  end
end
