require 'json'
require 'open-uri'
module Filter
  class ZoiBot
    ZOI_DATA_URI = "http://zoi.herokuapp.com/js/services.js"

    def update(p)
      t = p['text']
      return nil unless t =~ /^\:zoi/
      if t =~ /^\:zoi list/
        { username: 'zoi', text: fetch_data.map { |z| z["word"] }.uniq.sort.join(", ") }
      else
        { username: 'zoi', text: find_zoi_by_keyword(t.split(/\ /).last)["image"] }
      end
    end

    def find_zoi_by_keyword(keyword)
      data = fetch_data
      if keyword
        entry = data.select {  |z| z["word"].include?(keyword) }.sample
      end

      entry || data.sample
    end

    def fetch_data
      return @fetched_data if @fetched_data
      zoi_data = open(ZOI_DATA_URI).read
      zoi_data = zoi_data.
        match(/this.items = (.+?);/m)[1].
        gsub(/(word|image|src):/, "'\\1':").
        gsub("'", '"')
      @fetched_data = JSON.parse(zoi_data)
    end
  end
end
