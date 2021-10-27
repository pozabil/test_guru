class GistQuestionService
  def initialize(question)
    @question = question
    @test = @question.test
    @client = Octokit::Client.new(access_token: ENV['GITHUB_GIST_TOKEN'])
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    @client.last_response.status.in?(200..299) if @client.last_response.present?
  end

  private

  def gist_params
    {
      description: I18n.t('.service.gist_question_service.question_in_test', test_title: @test.title),
      files: {
        "#{[@test.title, @question.body[0, 25]].join(' ').parameterize(locale: :ru)}.txt" => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    answers = @question.answers.pluck(:body, :correct)
    answers.map! do |answer|
      answer[1] = answer[1] ? I18n.t('.service.gist_question_service.correct_answer') : ''
      answer.join('')
    end

    content = [@question.body, '', answers]
    content.join("\n")
  end
end
