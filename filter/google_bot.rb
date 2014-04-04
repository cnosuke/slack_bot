require 'json'
require 'open-uri'
GOOGLE_API = 'https://www.google.co.jp/search?q='
module Filter
  class GoogleBot
    def update(p)
      t = p['text']
      return nil unless t =~ /^\:google/
      query = t.split(/\s/)[1..-1].join(' ')
      { username: 'Google', text: "#{query}: #{GOOGLE_API+URI.encode(query)}" }
    end
  end
end
