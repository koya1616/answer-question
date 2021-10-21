class Answers::LikesController < LikesController
  private

  def set_likeable
    @likeable = Answer.find(params[:answer_id])
  end
end
