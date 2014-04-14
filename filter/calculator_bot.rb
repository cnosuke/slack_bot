module Filter
  class CalculatorBot
    def update(p)
      t = p['text']
      re = /^\:= /
      return nil unless t =~ re
      exp = t.gsub(re,'')
      return unless validate(exp)
      begin
        res = eval(exp)
      rescue SyntaxError
        res = "SyntaxError"
      end
      { username: 'Calculator', text: "#{exp} = #{res}" }
    end

    def validate(exp)
      !!(exp =~ /^(\d|\*|\+|\-|\/|\.|\ )+$/)
    end
  end
end
