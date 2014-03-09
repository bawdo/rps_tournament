class NaruogaBawdoPlayer < RpsTournament::Player

  OPTIONS = [:paper, :rock, :scissors]

  attr_accessor :results, :seq

  def initialize
    self.results = []
    self.seq     = false
  end

  def choose

    return OPTIONS.sample if results.empty?
    last_result = results.last.last
    last_my_choice = results.last[0]
    last_opponent_choice = results.last[1]

    if detect_sequence_player
      last_opponent_choice
    elsif last_result == :lose
      OPTIONS.sample
    elsif last_result == :win
      last_my_choice
    else
      (OPTIONS - [last_opponent_choice]).sample
    end
  end

  def result(my_choice, opponent_choice, result)
    results << [my_choice, opponent_choice, result]
  end

  private

  def last_six_opponent_plays
    results.length > 5 ? results[-6,6].map {|i| i[1] } : results.map {|i| i[1] }
  end

  def detect_sequence_player
    if results.length % 6 == 0
      self.seq = ( last_six_opponent_plays == [:rock, :scissors, :paper, :rock, :scissors, :paper] )
    end
    return seq
  end

end
