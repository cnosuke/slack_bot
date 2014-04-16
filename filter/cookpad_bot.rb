require 'json'
require 'open-uri'
COOKPAD_API = 'http://cookpad.com/s/post?keyword='
module Filter
  class CookpadBot
    def update(p)
      t = p['text']
       return nil unless t =~ /^\:recipe\ /
      query = t.split(/\s/)[1..-1].join(' ')
      { username: 'COOKPAD', text: "#{query}: #{COOKPAD_API+URI.encode(query)}" }
    end
  end
end
