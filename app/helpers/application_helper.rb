module ApplicationHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def question_form(quantity, form={})
    last_number = quantity % 100

    if last_number.between?(10, 20)
      result = last_number
    else
      result = quantity % 10
    end

    case result
    when 1
      form[:one]
    when 2..4
      form[:two_four]
    else
      form[:more]
    end
  end
end
