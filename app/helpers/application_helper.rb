module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end
end
