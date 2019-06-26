class VotesController < ApplicationController
  before_action :qtn_answ, only: [:create, :destroy]

  def create
    @qtn_answ = qtn_answ
    @vote = @qtn_answ.votes.create(user: current_user)

    redirect_to question_path(@qtn_answ.question_id) if @vote.votable_type == 'Answer'
    redirect_to question_path(@qtn_answ) if @vote.votable_type == 'Question'
  end

  def destroy
    @qtn_answ = qtn_answ
    @vote = @qtn_answ.votes.where(user: current_user).take.try(:destroy)

    redirect_to question_path(@qtn_answ.question_id) if @vote.votable_type == 'Answer'
    redirect_to question_path(@qtn_answ) if @vote.votable_type == 'Question'
  end

  private

  def qtn_answ
    if params[:question_id]
      Question.find(params[:question_id])
    else
      Answer.find(params[:answer_id])
    end
  end

end
