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
    text = doc.xpath('//pod').first(3).compact.map{|e| e.xpath('subpod/plaintext').inner_text }.join("\n")
    image = doc.xpath('//pod').first(3).compact.select{|e| e.xpath('subpod/plaintext').inner_text.size == 0}.map{|e| e.xpath('subpod/img').attr('src').value}.first
    @response = { 
      text: text,
      image: image
    }
  end

  def to_s
    @response[:text].size.zero? ? 'I don\'t know.' : "#{@response[:text]}\n#{@response[:image]}"
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
