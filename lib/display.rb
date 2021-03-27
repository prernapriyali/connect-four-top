# frozen-string-literal: true

# Handles text output to the terminal
module Display
  def welcome
    puts %(
            Welcome to \e[1;32;4mConnect Four\e[0m. This program is currently a 2-player game, but a computer may be added later.
            Briefly, the aim is to get four of your discs in either a row, column or diagonal.
            In order To place your disc you simply enter a column in which to drop your disc.
            The columns are numbered from 1 through to 7 inclusive (1 is the first column, 2 is the second and so on).
            For background on the TDD.......
            \e[2mThis program was constructed using \e[1mTest Driven Development\e[0;2m (TDD). In other words:
              I made some unit tests --> all fail as the program is not created
              Made the program --> created the methods etc.
              Ran the tests --> until all tests passed
              Refactored code --> make code look pretty\e[0m
          )
  end

  def ask_for_player_one_name
    puts "\nWhat is your player one's name?"
  end

  def ask_for_player_two_name
    puts "\nWhat is player two's name?"
  end

  def ask_for_disk_colour(player)
    puts "\n#{player.name.capitalize} please select a colour."
    puts "The colours are: \e[31m(R)ed, \e[32m(G)reen, \e[35m(M)agenta, \e[34m(B)lue \e[39mor \e[36m(C)yan?\e[0m"
    puts "Enter any of the bracketed letters or you will receive a \e[38;5;#{Random.rand(50..230)}mrandom colour\e[0m"
  end

  def request_column_message(player)
    puts "\e[1m#{player.name.capitalize}\e[0m, which column do you want to place your disc (#{player.disc})"
  end

  def invalid_column_message
    puts "\e[31mInvalid input\e[0m, please enter a number from \e[1m1 to 7\e[0m inclusive."
  end

  def full_column_warning
    puts "Sir/Madame, as you can see that column is at \e[33mfull capacity\e[0m. Please choose another. Thank you."
  end

  def winner_announcement(winner)
    puts %(
      Thank you for playing \e[1mConnect Four\e[0m The winner of this game is......
      #{winner.name} using #{winner.disc}!!!!!!!!!!!!!!
      Well done. You are a Connect Four champion... for now!
    )
  end

  def outro
    puts 'Ending program... Beep... Boop.'
  end

  def continue_program_message
    puts 'Enter \'c\' or \'continue\' to continue. Anything else will exit the program.'
  end
end
