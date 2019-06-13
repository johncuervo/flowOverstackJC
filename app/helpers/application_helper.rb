module ApplicationHelper
  def flash_msg(key)
    case key
     when 'notice' then 'alert alert-info'
     when 'success' then 'alert alert-success'
     when 'error' then 'alert alert-danger'
     when 'alert' then 'alert alert-warning'
   end
  end

  def gravatar_url(email, size)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    default_url = "http://mysite.com/myavatar.png" # Acá puedo poner una ruta para una imagen propia.
    default_url = "retro"
    url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI::escape(default_url)}"
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
