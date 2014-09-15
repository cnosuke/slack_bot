require 'yaml'
require 'open-uri'
module Filter
  class SasuoniBot
    SASUONI_DATA_URI = "http://sasuoni.herokuapp.com/yaml/sasuoni_images.yaml"

    def update(p)
      t = p['text']
      return nil unless t =~ /^\:sasuoni/
      if t =~ /^\:sasuoni list/
        { username: 'sasuoni', text: fetch_data.map { |z| z["word"] }.uniq.sort.join(", ") }
      else
        { username: 'sasuoni', text: find_sasuoni_by_keyword(t.split(/\ /).last)["image"] }
      end
    end

    def find_sasuoni_by_keyword(keyword)
      data = fetch_data
      if keyword
        entry = data.select {  |z| z["word"].include?(keyword) }.sample
      end

      entry || data.sample
    end

    def fetch_data
      return @fetched_data if @fetched_data
      sasuoni_data = open(SASUONI_DATA_URI).read
      @fetched_data = YAML.load(sasuoni_data)
    end
  end
end
