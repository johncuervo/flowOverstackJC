module QuestionsHelper
  def form_title
    @question.new_record? ? "Crear Pregunta" : "Editar Pregunta"
  end
end
