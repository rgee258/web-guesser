require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guesses = 5

get '/' do
  guess = params["guess"]
  cheat = params["cheat"]
  output = check(guess, @@secret_number)
  number = number_output(output, @@guesses)
  bg = bg_color(output)
  cheat_toggle = cheat_check(cheat)
  erb :index, :locals => {:number => number, :output => output, :bg => bg, :guesses => @@guesses, :cheat => cheat_toggle}
end

def check(guess, number)
  if (/^[0-9]+(?!.)/.match(guess).nil?)
    "Guess a number from 0 to 100!"
  else
    guess = guess.to_i
    if (guess > number)
      if (guess - number > 5)
        @@guesses -= 1
        "Way too high!"
      else
        @@guesses -= 1
        "Too high!"
      end
    elsif (guess < number)
      if (number - guess > 5)
        @@guesses -= 1
        "Way too low!"
      else
        @@guesses -= 1
        "Too low!"
      end
    elsif (guess == number)
      "You got it right!"
    end
  end
end

def number_output(check_output, guess_count)
  if (check_output == "You got it right!")
    @@secret_number = rand(100)
    @@guesses = 5
    "You win! Good job, let's reset and guess a new number!"
  elsif (guess_count == 0)
    @@secret_number = rand(100)
    @@guesses = 5
    "You lose! Nice try but you're out of guesses, the game has reset so try to guess a new number!"
  else
    ""
  end
end

def bg_color(check_output)
  if (check_output == "Way too high!" || check_output == "Way too low!")
    "background: red"
  elsif (check_output == "Too high!" || check_output == "Too low!")
    "background: #ff8080"
  elsif (check_output == "You got it right!")
    "background: green"
  end
end

def cheat_check(cheat)
  if (cheat == "true")
    "CHEAT ON | The secret number is: #{@@secret_number}"
  else
    ""
  end
end