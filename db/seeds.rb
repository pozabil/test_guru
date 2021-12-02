 Answer.destroy_all
 Question.destroy_all
 Test.destroy_all
 Category.destroy_all
 User.destroy_all

users = User.create!([
  {first_name: 'Messi', last_name: "Lopessi", email: 'loginho@mail.mail', password: '8arcelona'},
  {first_name: 'Paul', last_name: "Atreidusik", email: 'paulig@cofee.mem', password: 'classic'},
  {first_name: 'Khan-solo', last_name: "Pelmenev", email: 'falcon@x7.elon', password: 'wookie_is_love'},
])
categories = Category.create!([
  {title: 'front-end'},
  {title: 'back-end'},
  {title: 'general'},
])
tests = Test.create!([
  {title: 'Ruby базовый', level: 0, category_id: categories[1].id, creator_id: users.sample.id},
  {title: 'Ruby продвинутый', level: 1, category_id: categories[1].id, creator_id: users.sample.id},
  {title: 'Rails базовый', level: 1, category_id: categories[1].id, creator_id: users.sample.id},
  {title: 'HTML', level: 1, category_id: categories[0].id, creator_id: users.sample.id},
  {title: 'CSS', level: 2, category_id: categories[0].id, creator_id: users.sample.id},
  {title: 'SQL', level: 2, category_id: categories[2].id, creator_id: users.sample.id},
  {title: 'WEB', level: 0, category_id: categories[2].id, creator_id: users.sample.id}
])
questions = Question.create!([
  {body: 'Что такое CSS?', test_id: tests[4].id},
  {body: 'Как создать модель в Rails?', test_id: tests[2].id},
  {body: 'Как посылать сообщения объектам в Ruby?', test_id: tests[1].id},
  {body: 'Что такое интсанс-переменные уровня класса в Ruby?', test_id: tests[1].id},
  {body: 'Как создать методы в Ruby?', test_id: tests[0].id},
  {body: 'Что такое HTTP?', test_id: tests[6].id},
  {body: 'Как посылать HTTP запрос GET?', test_id: tests[6].id},
  {body: 'Как создать абзац в HTML?', test_id: tests[3].id},
  {body: 'Как получить таблицу в SQL', test_id: tests[5].id}
])
answers = Answer.create!([
  {body: 'Формальный язык описания внешнего вида веб-страницы', question_id: questions[0].id},
  {body: '$ bin/rails generate model', question_id: questions[1].id},
  {body: 'object.send(message)', question_id: questions[2].id},
  {body: 'это инстанс-переменные, определенные на уровне класса', question_id: questions[3].id},
  {body: 'def methodd_name; end', question_id: questions[4].id},
  {body: 'протокол прикладного уровня передачи данных', question_id: questions[5].id},
  {body: 'GET /example HTTP/1.1 Host: example.com', question_id: questions[6].id},
  {body: '<p></p>', question_id: questions[7].id},
  {body: 'SELECT * FROM table', question_id: questions[8].id}
])

users.each do |user|
  rand(2..6).times do
    random_test = tests.sample
    user.tests << random_test unless user.tests.exists?(id: random_test.id)
  end
end
