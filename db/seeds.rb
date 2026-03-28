# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "Cleaning database..."
Flat.destroy_all

puts "Creating 12 curated flats with optimized images..."

# Curated list of high-quality house images
image_urls = [
  "https://images.unsplash.com/photo-1554995207-c18c203602cb",
  "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688",
  "https://images.unsplash.com/photo-1484154218962-a197022b5858",
  "https://images.unsplash.com/photo-1512917774080-9991f1c4c750",
  "https://images.unsplash.com/photo-1580587771525-78b9dba3b914",
  "https://images.unsplash.com/photo-1518780664697-55e3ad937233",
  "https://images.unsplash.com/photo-1472224371017-08207f84aaae",
  "https://plus.unsplash.com/premium_photo-1661908377130-772731de98f6",
  "https://images.unsplash.com/photo-1523217582562-09d0def993a6",
  "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2",
  "https://plus.unsplash.com/premium_photo-1774048161194-268ac4f94b9e",
  "https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6"
]


# https://images.unsplash.com/photo-1554995207 first image
# https://images.unsplash.com/photo-1560448204-e02f11c3d0e2 ?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cGVudGhvdXNlfGVufDB8fDB8fHww


# Pro-Tip: Optimization parameters for Unsplash
# auto=format (chooses best file type), fit=crop (no stretching), w=800 (perfect width)
params = "?auto=format&fit=crop&w=800&q=80"

image_urls.each_with_index do |url, index|
  flat = Flat.create!(
    name: "#{Faker::Address.city_prefix} #{Faker::Adjective.positive.capitalize} #{[ 'Loft', 'Residence', 'Suite', 'Penthouse', 'Studio' ].sample}",
    address: Faker::Address.full_address,
    description: "A truly #{Faker::Adjective.positive} experience awaits you. #{Faker::Lorem.paragraph(sentence_count: 3)}",
    price_per_night: rand(75..500),
    number_of_guests: rand(1..8),
    picture_url: "#{url}#{params}"
  )
  puts "Created flat #{index + 1}: #{flat.name}"
end

puts "Success! You now have #{Flat.count} optimized flats in your database."
