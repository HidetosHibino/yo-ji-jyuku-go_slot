module ProfilesHelper
  def profile_link(user)
    inner_html = "#{image_tag user.avatar_url, class: 'img-circle elevation-2', size:'24x24'}#{user.name}".html_safe
    html = "#{link_to profile_path(user), class:'text-decoration-none' do
              inner_html
            end}"
    html.html_safe
    # html =  "#{link_to profile_path(user) do
    #           "#{image_tag user.avatar_url, class: 'img-circle elevation-2', size:'24x24'}#{user.name}".html_safe
    #         end}"
    # html.html_safe
  end
end
