# -*- coding: utf-8 -*-
module Mithril
  module DOM
    HTML_TAGS = %w(a abbr address area article aside audio b base bdi bdo big blockquote body br
                   button canvas caption cite code col colgroup data datalist dd del details dfn
                   dialog div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5
                   h6 head header hr html i iframe img input ins kbd keygen label legend li link
                   main map mark menu menuitem meta meter nav noscript object ol optgroup option
                   output p param picture pre progress q rp rt ruby s samp script section select
                   small source span strong style sub summary sup table tbody td textarea tfoot th
                   thead time title tr track u ul var video wbr)

    HTML_TAGS.each do |tag|
      define_method tag do |&block|
        create_node(tag, block)
      end
    end


    @@nodes_stack = []
    def parent
      @@nodes_stack.last
    end

    def parent?
      not @@nodes_stack.empty?
    end

    def create_node(tag, block)
      @current_node = Node.new(self, tag)
      parent.children << @current_node if parent?
      @current_node.tap do
        process_block(block) if block
      end
    end

    def process_block(block)
      @@nodes_stack << @current_node
      block.call if block
      @@nodes_stack.pop
    end

    def text(string)
      parent.children << string.to_s if parent?
    end
  end
end
