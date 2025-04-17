require "nokogiri"

module Jekyll
  module SmartalkFilter
    def highlight_smartalk(input)
      input.gsub(/Smartalk(?=[\s\.,;!\?:]|$)/i, '<span class="smartalk-word"><span class="smartalk-smart">Smar</span><span class="smartalk-talk">talk</span></span>')
    end

    def smartalkify_html(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)

      doc.traverse do |node|
        if node.text? && !ancestor_is_code_or_style?(node)
          node.replace(highlight_smartalk(node.text))
        end
      end

      doc.to_html
    end

    private

    def ancestor_is_code_or_style?(node)
      node.ancestors.any? { |ancestor| %w[script style code pre].include?(ancestor.name.downcase) }
    end
  end
end

Liquid::Template.register_filter(Jekyll::SmartalkFilter)

# הפעלת הפילטר אוטומטית על כל הדפים והפוסטים
Jekyll::Hooks.register [:pages, :posts], :post_render do |doc|
  if doc.output_ext == ".html"
    filter = Jekyll::SmartalkFilter.new
    doc.output = filter.smartalkify_html(doc.output)
  end
end
