module Mithril
  class Node
    attr_reader :params, :children, :styles, :classNames

    def initialize(dom, name)
      @dom = dom
      @classNames = [ name ]
      @params = {}
      @children = []
      @styles = []
    end

    def method_missing(clazz, arg = nil, &block)
      clazz = clazz.gsub('_', '-').gsub('--', '_')
      if clazz.start_with?('on') and arg
        arg = @dom.method(arg) if arg.is_a? String or arg.is_a? Symbol
        @params[clazz] = event_callback(arg)
      elsif clazz.end_with?('!')
        @params[:id] = clazz[0..-2]
      elsif clazz.end_with?('?')
        @classNames << clazz[0..-2] if arg
      else
        @classNames << clazz
      end

      process_block(block)
    end

    def process_block(block)
      @dom.process_block(block) if block
      self
    end

    def text(string)
      @children = string.to_s
      self
    end

    def event_callback(v)
      proc do |e|
        v.call(Support.wrap_event(e))
      end
    end

    def to_n
      tag = @classNames.join(".")
      params[:style] = @styles.join('') unless @styles.empty?
      `m(#{tag}, #{@params.to_n}, #{@children.to_n})`
    end

    def to_s
      "<#{@classNames.join(".")} #{@params.inspect}/>"
    end

    def to_s_params
      return unless @params.any?
      ' ' + @params.map do |k, v|
        "#{k}=\"#{v}\""
      end.join(' ')
    end

    def to_s_children
      return @children if @children.is_a?(String)
      return unless @children.any?
      @children
        .map(&:to_s)
        .join
    end
  end
end
