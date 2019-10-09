# frozen_string_literal: true
require 'html/pipeline'

HTML::Pipeline.require_dependency('commonmarker', 'MarkdownRewriteFilter')

class MarkdownRewriteFilter < HTML::Pipeline::TextFilter
  def initialize(text, context = nil, result = nil)
    super text, context, result
    @parser = context[:markdown_parser]
  end

  def call
    extensions = context.fetch(
      :commonmarker_extensions,
      %i[table strikethrough tagfilter autolink]
    )

    parse_options = :DEFAULT
    parse_options = [:UNSAFE] if context[:unsafe]

    doc = CommonMarker.render_doc(@text, parse_options, extensions)

    text = ''
    doc.each do |node|
      if @parser.class.method_defined?(node.type)
        text += @parser.send(node.type, node)
      elsif node.type == :document
        next
      else
        text += "#{node.to_commonmark}"
      end
    end

    text
  end
end
