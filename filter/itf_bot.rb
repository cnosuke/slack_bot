require 'json'
module Filter
  class ITFBot
    def update(p)
      t = p['text']
      return nil unless t =~ /^\:itf /
      { username: 'ITF', text: "https://soundcloud.com/yoichiro-yoshikawa/imagine-the-future-english-vir" }
    end
  end
end
