module Mithril
  module Wrapper
    def mount(div, app)
      `#{app}.view = function() { return #{app}.$view().$to_n(); }`
      `m.mount(#{div.to_n}, #{app});`
    end

    def render(div, app)
      `m.render(#{div.to_n}, #{app}.$render().$to_n());`
    end

    def redraw()
      `m.redraw()`
    end
  end
end
