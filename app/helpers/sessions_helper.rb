module SessionsHelper
  def flash_message(type)
    content_tag :p, flash[type], class: "flash #{type}" if flash[type]
  end

  def flash_messages
    flash_messages = []
    flash.keys.each do |type|
      flash_messages << flash_message(type)
    end
    flash_messages.join.html_safe
  end
end
