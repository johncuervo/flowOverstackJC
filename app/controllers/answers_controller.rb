class AnswersController < ApplicationController

    def create
      @question = Question.find(params[:question_id])
      @answer = @question.answers.new(answer_params)
      @answer.user = current_user

      respond_to do |format|
        if @answer.save
          format.html {redirect_to question_path(@question), notice: 'Respuesta creada correctamente.'}
          format.js # render create.js.erb
        else
          format.html { 'questions/show' }
          flash[:error] = 'La respuesta no se ha agregado correctamente'
        end
      end
    end

    def show
      @question = Question.find(params[:question_id])
      @answer = @question.find(params[:id])
    end

    def update
      if @answer.update(answer_params)
        redirect_to answer_path, notice: 'Respuesta editada correctamente.'
      else
        render :edit
      end
    end

    def destroy
      @question = Question.find(params[:question_id])
      @answer = @question.answers.find(params[:id])
      @answer.destroy

      respond_to do |format|
        format.html { redirect_to question_path(@question), notice: 'Respuesta eliminada correctamente.' }
        format.js
      end
    end

  private

    def answer_params
      params.require(:answer).permit(:content).merge(user: current_user)
    end

end
