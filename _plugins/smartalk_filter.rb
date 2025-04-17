module Jekyll
  module SmartalkFilter
    def highlight_smartalk(input)
      # מחפש את המילה Smartalk ומחליף אותה, כולל אחרי תווים כמו פסיק ונקודה
      input.gsub(/Smartalk(?=[\s\.,;!\?:]|$)/, '<span class="smartalk-word"><span class="smartalk-smart">Smar</span><span class="smartalk-talk">talk</span></span>')
    end
  end
end

Liquid::Template.register_filter(Jekyll::SmartalkFilter)
