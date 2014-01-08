FizzBuzz::Application.routes.draw do
  get 'fizz' => 'fizz_buzz#fizz'
  get 'buzz' => 'fizz_buzz#buzz'
  get 'fizz_buzz' => 'fizz_buzz#fizz_buzz'
  get 'fail' => 'fizz_buzz#fail'
  post 'answer' => 'fizz_buzz#answer'

  root to: 'fizz_buzz#index'
end
