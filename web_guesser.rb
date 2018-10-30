require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"].to_i
  output = check(guess, SECRET_NUMBER)
  number = number_output(output)
  erb :index, :locals => {:number => number, :output => output}
end

def check(guess, number)
  if (guess > number)
    if (guess - number > 5)
      "Way too high!"
    else
      "Too high!"
    end
  elsif (guess < number)
    if (number - guess > 5)
      "Way too low!"
    else
      "Too low!"
    end
  elsif (guess == number)
    "You got it right!"
  end
end

def number_output(check_output)
  if (check_output == "You got it right!")
    "The SECRET NUMBER is #{SECRET_NUMBER}"
  else
    ""
  end
end