require 'httparty'

# Supprimez toutes les entrées précédentes pour éviter les doublons
Festival.destroy_all

base_url = 'https://app.ticketmaster.com/discovery/v2/events?apikey=8pzSizXxBA19CHBxvdZGkO3O8uh6o6Ap&locale=*&countryCode=FR&segmentName=music&size=200'

page_number = 0
loop do
  response = HTTParty.get("#{base_url}&page=#{page_number}")
  break unless response.success?
  festivals_data = response['_embedded'] ? response['_embedded']['events'] : []
  festivals_data.each do |festival_data|
    country = festival_data['_embedded']['venues'][0]['country']['name'],
    city = festival_data['_embedded']['venues'][0]['city']['name']
    postal_code = festival_data['_embedded']['venues'][0]['postalCode']
    address = festival_data['_embedded']['venues'][0]['address']['line1']
    Festival.create(
      name: festival_data['name'],
      description: festival_data['description'],
      location: "#{address}, #{postal_code} #{city}, #{country}",
      start_date: festival_data['dates']['start']['dateTime'],
      min_price: festival_data['priceRanges'] ? festival_data['priceRanges'][0]['min'] : nil,
      max_price: festival_data['priceRanges'] ? festival_data['priceRanges'][0]['max'] : nil,
      image: festival_data['images'].max_by { |image| image['width'] }['url'],
    )
  end

  page_number += 1
end

puts "Created #{Festival.count} festivals"
