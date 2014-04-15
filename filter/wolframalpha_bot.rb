require 'nokogiri'
require 'open-uri'

class Wolframalpha
  API_URL = 'http://api.wolframalpha.com/v2/query?format=image,plaintext'
  def initialize(exp)
    @exp = exp
    @api_key = api_key
  end

  def self.exec(exp)
    me = new(exp)
    me.exec!
    me
  end

  def exec!
    doc = Nokogiri.parse(get_api)
    di = doc.xpath('//pod').first
    text = di.xpath('subpod/plaintext').inner_text,
    image = (di.xpath('subpod/img') ? di.xpath('subpod/img').attr('src').value : nil)
    @response = { 
      text: (text.is_a?(String) ? text : text.first),
      image: image
    }
  end

  def to_s
    @response[:text] + "\n" + @response[:image]
  end

  def get_api
    open("#{API_URL}&appid=#{@api_key}&input=#{URI.encode(@exp)}").read
  end

  def exp
    @exp
  end

  def api_key
    ENV['WOLFRAM_API_KEY'] || open('wolfram_api_key').read.gsub(/\s/,'')
  end
end

module Filter
  class WolframalphaBot
    include Math
    def update(p)
      t = p['text']
      re = /^\:w= /
      return nil unless t =~ re
      exp = t.gsub(re,'')
      res = Wolframalpha.exec(exp)
      { username: 'Wolframalpha', text: res.to_s }
    end
  end
end
