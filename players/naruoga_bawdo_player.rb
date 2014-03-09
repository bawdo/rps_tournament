class NaruogaBawdoPlayer < RpsTournament::Player

  OPTIONS = [:paper, :rock, :scissors]

  attr_accessor :results, :seq

  def initialize
    self.results = []
    self.seq     = false
  end

  def choose
    return OPTIONS.sample if results.empty?
    last_my_choice       = results.last[0]
    last_opponent_choice = results.last[1]
    last_result          = results.last[2]

    if detect_sequence_player
      last_opponent_choice
    elsif detect_not_rock
      [:scissors, :rock].sample
    elsif last_result == :lose
      OPTIONS.sample
    elsif last_result == :win
      last_my_choice
    else
      OPTIONS.sample
    end
  end

  def result(my_choice, opponent_choice, result)
    results << [my_choice, opponent_choice, result]
  end

  private

  def last_six_opponent_plays
    (results.length % 6 == 0 ? results[-6,6] : results).map {|i| i[1] }
  end

  def detect_not_rock
    (OPTIONS - last_six_opponent_plays.uniq) == [:rock]
  end

  def detect_sequence_player
    if results.length % 6 == 0
      self.seq = ( last_six_opponent_plays == [:rock, :scissors, :paper, :rock, :scissors, :paper] )
      self.results = results[-6,6]
    end
    return seq
  end

end
