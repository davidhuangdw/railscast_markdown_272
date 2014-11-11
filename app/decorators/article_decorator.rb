class HighlightCode <  Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.scan(code, language).div
  end
end


class ArticleDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def rendered
    h.sanitize markdown.render(object.content || ''), attributes:%w(id class style)
    # h.raw markdown.render(object.content || '')
  end

  def markdown
    @@markdown ||= Redcarpet::Markdown.
        new(HighlightCode.new(hard_wrap:true, filter_html:true),fenced_code_blocks:true)
  end

end
