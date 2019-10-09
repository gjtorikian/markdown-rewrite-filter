# frozen_string_literal: true
require 'test_helper'

class HTML::Pipeline::MarkdownRewriteFilterTest < Minitest::Test
  class CustomParser
    def header(node)
      text = node.first_child.string_content
      level = node.header_level
      result = <<~DOC
      {level: #{level}, text: #{text}}
      #{node.to_commonmark}
      DOC
    end
  end

  def fixture(name)
    File.open(File.join("#{File.expand_path(File.dirname(__FILE__))}", 'fixtures', name)).read
  end

  def test_it_works
    results = MarkdownRewriteFilter.new(fixture('headers.md'), markdown_parser: CustomParser.new).call

    expected = <<~DOC
    {level: 1, text: Words}
    # Words

    Some words
    {level: 2, text: Words}
    ## Words

    More **words?**
    DOC

    assert_equal results.chomp, expected.chomp
  end
end
