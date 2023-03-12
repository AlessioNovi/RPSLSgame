class Move
  def >(other_move)
    beats.each { |el| return true if el.new.class == other_move.class }
    false
  end

  def to_s
    self.class.to_s
  end

  private

  attr_accessor :beats
end

class Rock < Move
  def initialize
    self.beats = [Scissors, Lizard]
  end
end

class Paper < Move
  def initialize
    self.beats = [Rock, Spock]
  end
end

class Scissors < Move
  def initialize
    self.beats = [Lizard, Paper]
  end
end

class Lizard < Move
  def initialize
    self.beats = [Spock, Paper]
  end
end

class Spock < Move
  def initialize
    self.beats = [Rock, Scissors]
  end
end

class Player
  attr_accessor :move

  VALUES = { "rock" => Rock, "paper" => Paper, "scissors" => Scissors,
             "lizard" => Lizard, "spock" => Spock }
end

class Human < Player
  attr_accessor :score

  def initialize
    @score = 0
  end

  def choose(choice)
    self.move = Player::VALUES[choice].new
  end
end

class Computer < Player
  attr_accessor :score

  def initialize
    @score = 0
  end

  def choose
    self.move = Player::VALUES[Player::VALUES.keys.sample].new
  end
end

class RPSGame
  attr_accessor :human, :computer, :game_history

  def initialize
    @human = Human.new
    @computer = Computer.new
    @game_history = []
  end

  def update_game_history
    @game_history << [human.move, computer.move]
  end

  def add_score
    human.score += 1 if human.move > computer.move
    computer.score += 1 if computer.move > human.move
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def grandwinner?
    if human.score == 5
      'Player is the Grandwinner!!!'
    elsif computer.score == 5
      'Computer is the Grandwinner!!!'
    end
  end

  def display_round_winner
    if human.move > computer.move
      'Player won!'
    elsif computer.move > human.move
      'Computer won'
    else
      "It's a tie!"
    end
  end
end