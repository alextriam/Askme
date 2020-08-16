class UsersController < ApplicationController
  def index
    # Создаём массив из двух болванок пользователей. Вызываем метод # User.new, который создает модель, не записывая её в базу.
    # У каждого юзера мы прописали id, чтобы сымитировать реальную
    # ситуацию – иначе не будет работать хелпер путей
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
    name: 'Vadim',
    username: 'installero'

    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new

    @question_quantity = @questions.size
    @question_form = word_form(@question_quantity)
  end

  private
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
