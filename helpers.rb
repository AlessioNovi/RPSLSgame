helpers do
  def display_score
    "<div class = 'score'><h1>Current Game Score:</h1>
    <p>Player score: #{@player_score}</p><p id = 'divider'>-</p><p>Computer score: #{@computer_score}</p></div>"
  end

  def display_moves_history
    return if @game_history.empty?

    text = "<div class = 'history'><p>Previous game moves:</p>"
    @game_history.each_with_index do |round, i|
      text << "<p>Round #{i + 1}: Player: #{round.first} | Computer: #{round.last}</p>"
    end
    text + '</div>'
  end

  def active_session?
    !!session[:active_game]
  end

  def setup_game
    session[:game] = RPSGame.new
    session[:active_game] = true
  end

  def teardown_game
    session.delete(:game)
    session.delete(:active_game)
  end
end
