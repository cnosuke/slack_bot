WEATHER_API = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=130010'.freeze
require 'json'
require 'open-uri'
module Filter
  class WeatherBot
    def update(p)
      return nil unless p['text'] =~ /^\:weather /
      {
        username: "Weather",
        text: forecast
      }
    end
    def weather
      @weather ||= JSON.parse(open(WEATHER_API).read)
    end
    def forecast
      f = weather['forecasts']
      "...\n" + f.map{ |e| forecast_day(e) }.join
    end
    def forecast_day(d)
      str =<<EOB
#{d["dateLabel"]}(#{d["date"]}): #{d["telop"]}
  温度: #{temperature(d["temperature"])}
EOB
    end
    def temperature(d)
      d.map{ |k,v|
        if v
          "#{k}: #{v['celsius']}度"
        end
      }.compact.join(", ")
    end
  end
end
