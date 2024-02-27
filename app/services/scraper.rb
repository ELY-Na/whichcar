require 'nokogiri'
require 'open-uri'

class Scraper
  # if you dont have initialize the class will not work
  def self.scrap_links
    links = []
    page = 1
    while page < 10
      url = URI.parse("https://www.aramisauto.com/achat/recherche?page=#{page}")
      response = Net::HTTP.get_response(url)

      if response.is_a?(Net::HTTPSuccess)
        html_file = URI.open(url).read
        doc = Nokogiri::HTML.parse(html_file)
        doc.search('.real-link.vehicle-info-link').each do |link|
          links << "https://www.aramisauto.com" + link.attribute('href').value
        end
        page += 1
      else
        puts "Error fetching page #{page}: #{response.message}"
      end
    end
    links
  end

  def initialize(url)
    puts url
    html_file = URI.open(url).read
    @html_doc = Nokogiri::HTML.parse(html_file)
  end

  def model
    model_element = @html_doc.search('.price-information').first.search('.subtitle-1').text.strip
  end

  def car_type
    match = @html_doc.search('.price-information').first.search('.price-information-row').text.strip.match(/occasion|0km/)
    match[0] if match
  end

  def price
    @html_doc.search('.price-amount').text.strip.gsub(/[^\d]/, '').to_i
  end

  def fuel
    if (element = @html_doc.search('.product-key-points-list').children.at('div.labels-title:contains("Carburant")')).present?
      match = element.next_element.text.strip
    else
      @html_doc.search('.key-points-item:contains("Énergie") .labels-body').text.strip
    end
  end

  def gearbox
    match = @html_doc.search('.product-key-points-list').children.at('div.labels-title:contains("Boîte de vitesses")').next_element.text.strip.match(/(automatique|manuelle)/)
  end

  def truck
    match = @html_doc.search('.technical-infos-content')[0].search('.valkyrie-collapsable')[0].text.match(/[1-9][0-9][0-9]/)
    match[0] if match
  end
  
  def horse_power_fiscal
    match = @html_doc.search('.technical-infos-content').children.at('.valkyrie-collapsable .item:contains("Puissance fiscale")').at('span').text.match(/\d+ CV/)
    match[0].split[0].to_i if match
  end

  def horse_power
    match = @html_doc.search('.technical-infos-content').children.at('.valkyrie-collapsable .item:contains("Puissance DIN")').at('span').text.match(/\d+ ch/)
    match[0].split[0].to_i if match
  end

  def passengers
    match = @html_doc.search('.technical-infos-content')[0].children.at('.valkyrie-collapsable .item:contains("Nombre de places")').text.match(/\d/)
    match[0].to_i if match
  end

  def critair
    match = @html_doc.search('.product-key-points-list').children.at('div.labels-title:contains("Certificat")').next_element.text.strip.match(/Crit'Air \d/)
    match[0].last.to_i if match
  end

  def year
    match = @html_doc.search('.product-key-points-list').children.at('div.labels-title:contains("Mise en circulation")').next_element.text.strip.match(/\d{4}/)
    match[0] if match
  end

  def photo
    if (element = @html_doc.search('.slider')[0].search('.image-container')).present?
      image_element = @html_doc.search('.slider')[0].search('.image-container').first.at('img')['src']
    else
      image_element = @html_doc.search('.product-adaptive-image').at('img')['src']
    end
    new_width = 180
    image_element = image_element.sub(/width=\d+/, "width=#{new_width}")
  end

end
