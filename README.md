# markdown-rewrite-filter

A filter to rewrite Markdown for the [HTML::Pipeline](https://github.com/jch/html-pipeline).

## Installation

Add this line to your application's Gemfile:

    gem 'extended-markdown-filter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extended-markdown-filter

## Usage

The simplest way to do this is

``` ruby
require 'markdown-rewrite-filter'
```

Then just use the HTML pipeline normally. With Jekyll, this is meant to be used with another plugin in conjunction, https://github.com/gjtorikian/jekyll-html-pipeline.

A minimum config file might look like:
``` yaml
gems:
  - markdown-rewrite-filter
  - jekyll-html-pipeline

markdown: HTMLPipeline
html_pipeline:
  filters:
    - "MarkdownRewriteFilter"
    - "MarkdownFilter"
```
