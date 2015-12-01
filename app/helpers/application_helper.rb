module ApplicationHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if type == :timeout
      next if type == :timedout
      type = :success if type == :notice
      type = :danger if type == :alert
      text = content_tag(:div,
                         content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                             message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def tick if_true
    return if_true ? '✔' : '✗'
  end

  def current_user
    return @worker
  end
end
