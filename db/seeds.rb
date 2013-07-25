IMAGE_CATEGORIES = ["sports", "animals", "transport", "nightlife", "nature",
                    "city", "people", "food", "technics", "abstract"]

def generate_image_url(category, img_id)
  img_size_params = "#{rand(100...200)}/#{rand(100...200)}"
  "http://lorempixel.com/#{img_size_params}/#{category}/#{img_id}"
end

IMAGE_CATEGORIES.each do |category|
  count = 0
  10.times do
    count += 1
    Poem.create(original_text: Faker::Lorem.paragraph(10),
                    poem_text: Faker::Lorem.paragraph(10),
                        title: Faker::Lorem.words(2).join(" "),
                          pic: generate_image_url(category, count))
    puts "seeding poem #{count}, for category #{category}"
  end
end
