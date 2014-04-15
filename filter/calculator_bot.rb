module Filter
  class CalculatorBot
    include Math
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
      !!(exp =~ /^(\d|\*|\+|\-|\/|\.|\ |\(|\)|#{math_re})+$/)
    end
    def math_re
      %w(acos acosh asin asinh atan atan2 atanh cbrt cos cosh erf erfc exp frexp gamma hypot ldexp lgamma log log10 log2 rsqrt sin sinh sqrt sqrt tan tanh PI E).join("|")
    end
  end
end
