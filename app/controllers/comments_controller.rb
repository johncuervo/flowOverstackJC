class CommentsController < ApplicationController
  before_action :qtn_answ, only: [:create, :destroy]
  before_action :comment_params, only: [:create, :destroy]

  def create
    @qtn_answ = qtn_answ
    @comment = @qtn_answ.comments.new comment_params

    respond_to do |format|
      if @comment.save
        format.html { redirect_to question_path(@qtn_answ.question_id) } if @comment.commentable_type == 'Answer'
        format.html { redirect_to question_path(@qtn_answ)  } if @comment.commentable_type == 'Question'
        format.js
      else
        format.html { 'questions/show' }
        flash[:error] = 'El comentario no se ha agregado correctamente'
      end
    end
  end

  def destroy
    @qtn_answ = qtn_answ
    @comment = @qtn_answ.comments.find(params[:id])
    @comment.destroy

    redirect_to root_path
    # respond_to do |format|
    #   format.js
    # end
  end

  private

  def qtn_answ
    if params[:question_id]
      Question.find(params[:question_id])
    else
      Answer.find(params[:answer_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
