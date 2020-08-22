class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def reject_user
    redirect_to root_path, alert: 'Вам сюда низя!'
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Метод, который редиректит посетителя на главную с предупреждением о
  # нарушении доступа. Мы будем использовать этот метод, когда надо запретить
  # пользователю что-то.
  def reject_user
    redirect_to root_path, alert: 'Вам сюда низя!'
  end
end
