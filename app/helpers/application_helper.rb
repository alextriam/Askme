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

  def word_form(quantity)
      form = {one: 'вопрос', two_four: 'вопроса', more: 'вопросов'}
      last_number = quantity % 100

      if last_number >= 10 && last_number <= 20
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
