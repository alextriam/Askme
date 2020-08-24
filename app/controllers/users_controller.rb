class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  # Порядок before_action очень важен! Они выполняются сверху вниз

  # Проверяем, имеет ли юзер доступ к экшену, делаем это для всех действий, кроме
  # :index, :new, :create, :show — к ним есть доступ у всех, даже у анонимных юзеров.
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
      @user = User.new(user_params)

      if @user.save
        session[:user_id] = @user.id
        redirect_to root_url, notice: 'вы успешно зарегистрированы, добро пожаловaть на сайт'
      else
        render 'new'
      end
  end

  def edit
  end

  def show
    @user = User.find params[:id]
    @questions = @user.questions.order(created_at: :desc)
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
    @new_question = @user.questions.build
  end

  def update
    # Получаем параметры нового (обновленного) пользователя с помощью метода user_params
    @user = User.find params[:id]
    # пытаемся обновить юзера
    if @user.update(user_params)
      # Если получилось, отправляем пользователя на его страницу с сообщением
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      # Если не получилось, как и в create, рисуем страницу редактирования
      # пользователя со списком ошибок
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end

  def load_user
    # защищаем от повторной инициализации с помощью ||=
    @user ||= User.find params[:id]
  end

  def authorize_user
    reject_user unless @user == current_user
  end
end
