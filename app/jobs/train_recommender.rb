class TrainRecommenderJob < ApplicationJob
  def perform
    model = Disco::Recommender.new
    data = UserInteraction.pluck(:user_id, :product_id)
    model.fit(data)

    File.write("tmp/disco_model.bin", Marshal.dump(model))
  end
end
