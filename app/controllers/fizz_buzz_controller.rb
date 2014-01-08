class FizzBuzzController < ApplicationController
  def fizz
    @message = "Fizz."
  end

  def buzz
    @message = "Buzz."
  end

  def fizz_buzz
    @message = "Fizz Buzz."
  end

  def fail
    @message = params[:number].strip.to_i.to_s
  end

  def index
  end

  def answer
    number = params[:number].strip.to_i

    if number % 5 == 0 && number % 3 == 0
      redirect_to fizz_buzz_url
    elsif number % 5 == 0
      redirect_to fizz_url
    elsif number % 3 == 0
      redirect_to buzz_url
    else
      redirect_to fail_url(number: number)
    end
  end
end
