require 'json'
require 'open-uri'
AMAZON_API = 'http://www.amazon.co.jp/s/ref=nb_sb_noss_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&url=search-alias%3Daps&field-keywords='
module Filter
  class AmazonBot
    def update(p)
      t = p['text']
      return nil unless t =~ /^\:amazon/
      query = t.split(/\s/)[1..-1].join(' ')
      { username: 'Amazon', text: "#{query}: #{AMAZON_API+URI.encode(query)}" }
    end
  end
end
