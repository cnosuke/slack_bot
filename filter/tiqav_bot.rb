require 'json'
require 'open-uri'
TIQAV_API = 'http://api.tiqav.com/search.json?q='
module Filter
  class TiqavBot
    def update(p)
      t = p['text']
      return nil unless t =~ /^\:tiqav /
      query = t.split(/\s/)[1..-1].join(' ')
      { username: 'tiqav', text: "#{query}: #{get_image_url(query)}" }
    end
    def get_image_url(query)
      j = JSON.parse(open(TIQAV_API+URI.encode(query)).read).first(5).sample
      "http://tiqav.com/#{j['id']}.#{j['ext']}"
    end
  end
end
