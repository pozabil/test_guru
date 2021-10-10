module FooterHelper
  def year
    Time.now.year
  end

  def github_url(author, project_title)
    link_to project_title, "https://github.com/#{author}/#{project_title.underscore}",
      class: (admin_panel? ? "link-light" : "link-primary")
  end
end
