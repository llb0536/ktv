# -*- encoding : utf-8 -*-
module TextHelper

  def truncate_html(text, max_length, ellipsis = "...")
    ellipsis_length = ellipsis.length     
    doc = Nokogiri::HTML::DocumentFragment.parse text
    content_length = doc.inner_text.length
    actual_length = max_length - ellipsis_length
    content_length > actual_length ? doc.truncate(actual_length).inner_html + ellipsis : text.to_s
  end

end

module NokogiriTruncator
  module NodeWithChildren
    def truncate(max_length)
      return self if inner_text.length <= max_length
      truncated_node = self.dup
      truncated_node.children.remove

      self.children.each do |node|
        remaining_length = max_length - truncated_node.inner_text.length
        break if remaining_length <= 0
        truncated_node.add_child node.truncate(remaining_length)
      end
      truncated_node
    end
  end

  module TextNode
    def truncate(max_length)
      Nokogiri::XML::Text.new(content[0..(max_length - 1)], parent)
    end
  end

end

Nokogiri::HTML::DocumentFragment.send(:include, NokogiriTruncator::NodeWithChildren)
Nokogiri::XML::Element.send(:include, NokogiriTruncator::NodeWithChildren)
Nokogiri::XML::Text.send(:include, NokogiriTruncator::TextNode)
