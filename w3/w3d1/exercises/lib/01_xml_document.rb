#!/usr/bin/env ruby

# -------------------------------------------------------
# 01_xml_document.rb - Lizzi Sparks - May 2016
#
# `XmlDocument` class: takes advantage of `method_missing`
# to create XML tags, using
# `XmlDocument.tag_name({attr1_name => value1, ...}) { content }`
# to make <start_tag> content </end_tag> OR same as above
# without the block to make <empty_tag/>.
#
# Methods:
# - `XmlDocument#initialize(`true` or `false`)` : input
# logic is assigned to `@multi_line`. If none specified,
# `@multi_line` is set to `false`.
#
# - `XmlDocument#method_missing` : `method_name` and `args`
# correspond to `XmlDocument.method_name(args)`, `args` is
# an array containing all arguments in the missing method;
# in this case, a hash of XML attribute names and values
# needed for the start tag/empty tag. If missing method was
# called with a block, string returned is a pair of start
# and end tags wrapping the content of the block; without
# a block, string returned is an empty tag.
# 
# -------------------------------------------------------

class XmlDocument
  attr_reader :multi_line

  def initialize(multi_line = false)
    @multi_line = multi_line
  end

  def method_missing(method_name, *args, &text)
    name = method_name.to_s

    attr = ""
    element = ""

    if args[0]
      args[0].each { |attr_name, value| attr << %( #{attr_name}="#{value}") }
    end

    if text
      start_tag = "<#{name}#{attr}>"
      content = ""
      end_tag = "</#{name}>"

      if @multi_line
        start_tag += %(\n)
        text.call.each_line { |line| content << %(  #{line}) } 
        end_tag += %(\n)
      else
        content << text.call
      end

      element << start_tag << content << end_tag
    else
      empty_element_tag = %(<#{name}#{attr}/>)
      empty_element_tag += %(\n) if @multi_line

      element << empty_element_tag
    end

    element
  end
end
