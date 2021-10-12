module ApplicationHelper
  def admin_panel?
    request.path.starts_with?('/admin')
  end
end
