class Questions::LikesController < LikesController
  private

  def set_likeable
    @likeable = Question.find(params[:question_id])
  end
end
