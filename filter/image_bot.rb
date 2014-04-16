require 'json'
require 'google-search'
module Filter
  class ImageBot
    def update(p)
      t = p['text']
      return nil unless t =~ /^\:image /
      query = t.split(/\s/)[1..-1].join(' ')
      { username: 'image', text: "#{query}: #{get_image_url(query)}" }
    end
    def get_image_url(query)
      Google::Search::Image.new(query: query).first.uri
    end
  end
end
