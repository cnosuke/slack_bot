module Filter
  class PingBot
    def update(p)
      t = p['text']
      return nil unless t =~ /^\:ping/
      { username: 'PingBot', text: "PONG" }
    end
  end
end
