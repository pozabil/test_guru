module BadgesHelper
  def delete_badge(badge)
    link_to t('delete'),
            admin_badge_path(badge),
            method: :delete,
            data: { confirm: user_signed_in? ? t('helpers.badges_helper.delete_confirmation') : nil },
            class: "link-danger"
  end
end
