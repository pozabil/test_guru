module NavHelper
  def home_link
    link_to 'TestGuru', root_path, class: "navbar-brand ms-3", style: "font-size: xx-large"
  end

  def admin_panel
    link_to image_tag("admin_link.svg", alt: "Admin logo", height: "32"), admin_root_path,
      class: ( "navbar-brand" + " svg-invert" if admin_panel? )
  end

  def signup_link
    link_to t('signup'), new_user_registration_path
  end

  def edit_user_link
    link_to t('edit_user'), edit_user_registration_path, class: (admin_panel? ? "link-light" : "link-primary")
  end

  def login_link
    link_to t('login'), new_user_session_path
  end

  def logout_link
    link_to t('logout'),
            destroy_user_session_path,
            method: :delete,
            data: { confirm: t('logout_confirm') },
            class: (admin_panel? ? "link-light" : "link-primary")
  end

  def gists_link
    link_to t('gists'), admin_gists_path, class: "ms-2 link-light"
  end

  def badge_managment_link
    link_to t('.badge_managment'), admin_badges_path, class: "me-auto link-light"
  end

  def view_badges_link
    link_to t('.view_badges'), user_badges_path, class: "ms-3 btn btn-outline-dark"
  end

  def view_my_badges_link
    link_to t('.view_my_badges'), user_badges_path, class: "ms-3 btn btn-outline-danger"
  end

  def view_all_badges_link
    link_to t('.view_all_badges'), badges_path, class: "ms-3 btn btn-outline-danger"
  end
end
