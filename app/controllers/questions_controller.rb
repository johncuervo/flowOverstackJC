class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

    def index
      @questions = Question.all.order(created_at: :desc)
      @questions = Question.search(params[:search]).order(created_at: :desc)
    end

    def new
      @question = Question.new
    end

    def create
      @question = Question.new(question_params)
      @question.user = current_user
      if @question.save
        redirect_to questions_path, notice: 'Pregunta creada correctamente.'
      else
        render :new
      end
    end

    def show

    end

    def edit
    end

    def update
      if @question.update(question_params)
        redirect_to question_path, notice: 'Pregunta editada correctamente.'
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      redirect_to questions_path, notice: 'Pregunta eliminada correctamente.'
    end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :content, :user_id)
    end

end
