namespace :recommender do
  desc "Train the Disco recommendation model"
  task train: :environment do
    model = Disco::Recommender.new
    data = UserInteraction.pluck(:user_id, :product_id)
    model.fit(data)
    model.save("tmp/disco_model.json")
    puts "Recommender trained and saved!"
  end
end
