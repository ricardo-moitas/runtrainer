class ChatsController < ApplicationController
  def chat
    @run = current_user.runs.find(params[:id])
    @messages = @run.messages.order(created_at: :asc)
    @history = current_user.runs.order(date: :desc)
  end

  def create
    @run = current_user.runs.find(params[:id])
    user_input = params[:message]
    Message.create!(run: @run, content: user_input, role: 'user')
    history = current_user.runs.order(date: :desc).first(5)
    ai_response = OpenAiService.new(@run, history, user_input).call
    Message.create!(run: @run, content: ai_response, role: 'ai')
    redirect_to chat_run_path(@run)
  end
end
