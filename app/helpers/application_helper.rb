module ApplicationHelper
  def post_page?
    controller_name == 'posts' && action_name == 'show'
  end
end
