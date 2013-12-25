module CommitsHelper
  def highlight_message(message, keyword)
    keywords = keyword.split(" ")
    highlighter = '<span class="text-primary">\1</span>'
    message = highlight(message, keywords, highlighter: highlighter)
    simple_format(message)
  end

  def page
    params[:page].nil? ? 1 : params[:page].to_i
  end
end
