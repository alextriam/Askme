module QuestionsHelper
  def question_author(question)
    if question.author
      link_to "@#{question.author.username}", user_path(question.author)
    else
      "<span><i>Anonimus</i></span>".html_safe
    end
  end
end
