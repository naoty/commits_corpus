module CommitsHelper
  def highlight_message(message, keyword)
    keywords = keyword.split(" ")
    highlighter = '<span class="text-primary">\1</span>'
    message = highlight(message, keywords, highlighter: highlighter)
    simple_format(message)
  end
end
