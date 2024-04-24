require 'nokogiri'
require 'mechanize'

class WikipediaBot
  def initialize
    @agent = Mechanize.new
  end

  def fetch_person_info(name)
    url = "<https://en.wikipedia.org/wiki/#{name.gsub(' ', '_')}>"
    page = @agent.get(url)
    doc = Nokogiri::HTML(page.body)

    # Exemple d'extraction d'informations
    birthplace = doc.at_css('.infobox .birthplace').text.strip
    deathplace = doc.at_css('.infobox .deathplace').text.strip

    # Vous pouvez ajouter plus de logique d'extraction ici...

    {
      name: name,
      birthplace: birthplace,
      deathplace: deathplace
    }
  rescue => e
    puts "Une erreur s'est produite lors de la récupération des informations pour #{name}: #{e.message}"
    return nil
  end
end

# Exemple d'utilisation du bot
bot = WikipediaBot.new
person_info = bot.fetch_person_info("Albert_Einstein")

if person_info
  puts "Informations sur #{person_info[:name]} :"
  puts "Lieu de naissance : #{person_info[:birthplace]}"
  puts "Lieu de décès : #{person_info[:deathplace]}"
end