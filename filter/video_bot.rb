require 'json'
require 'google-search'
module Filter
  class VideoBot
    def update(p)
      t = p['text']
      return nil unless t =~ /^\:video/
      query = t.split(/\s/)[1..-1].join(' ')
      { username: 'Video', text: "#{query}: #{get_video_url(query)}" }
    end
    def get_video_url(query)
      Google::Search::Video.new(query: query).first.uri
    end
  end
end
