def run_game
  game = Game.new
end

class Game
  def initialize
    @deck = Deck.new(2)
    @deck.shuffle

    @wallet = Wallet.new(100)
    @wager_amt = 10

    puts "~ Blackjack ~"

    puts "Welcome to Blackjack. Would you like to play? (Y/N)"

    user_command = gets.chomp
    print "\n"
    if user_command == "y"
      set_table
      puts "(H)it or (S)tand?"

    else
      puts "Bye!"
    end


  end

  def show_cards(player,hide_card)
    @deck.hands[player].show(hide_card)
  end

  def set_table
    @deck.create_seats(1)

    print "Your cards: "
    show_cards(0,false)
    print "| "
    @wallet.bet(@wager_amt)
    print " | "
    @wallet.print_balance
    print "\n"

    print "Dealer cards: "
    show_cards(1,true)
    print "\n\n"
  end

  # def wager
  #   @wallet.bet(@wager_amt)
  # end
  #

  #
  # def deal(num_cards)
  #   card_dealt = 0
  #   num_cards.times do
  #     card_dealt += 1
  #     @seats.each do |seat|
  #       @hands[seat] << @shoe.top_card_key
  #     end
  #   end
  #
  #   puts @seats
  #   puts @hands
  # end
  #


end

class Wallet
  attr_accessor :balance, :wager

  def initialize(initial_money)
    @balance = initial_money.to_i
  end

  def bet(wager)
    @wager = wager
    @balance -= @wager
    print "Wager: #{@wager}"
  end

  def add(winnings)
    @balance += winnings.to_i
  end

  def print_balance
    print "Balance: #{@balance}."
  end

end

class Hand
  attr_reader :hand

  def initialize
    @hand = []
  end

  def add_card(dealt_card)
    @hand << dealt_card
  end

  def show(hide_card)
    @hand.each do |card|
      if hide_card == true
        print "[hidden card] "
        hide_card = false
      else
        print "[#{card.face} of #{card.suit}] "
      end
    end
  end

end

class Card
  attr_reader :suit, :face

  def initialize(suit,face)
    @suit = suit
    @face = face
  end

end

class Deck
  attr_reader :deck, :hands

  def initialize(num_decks)
    @suits = ["clubs","diamonds","hearts","spades"]
    @rank_value_pair = {"ace"=>[1,11],"2"=>2,"3"=>3,"4"=>4,"5"=>5,"6"=>6,"7"=>7,"8"=>8,"9"=>9,"10"=>10,"jack"=>10,"queen"=>10,"king"=>10}
    @deck = []
    @faces = []

    @rank_value_pair.each { |face,value| @faces << face }

    num_decks.times do
      @suits.each do |suit|
        @faces.each do |face|
          @deck << Card.new(suit,face)
        end
      end
    end

    @deck
  end

  def deal
    @dealt_card = @deck.shift
    @dealt_card
  end

  def create_seats(num_players)
    @seats = [*0..num_players]
    @hands = []

    for turn in 1..2
      for seat in 0..num_players
        @hands[seat] = Hand.new if turn == 1
        @hands[seat].add_card(deal)
      end
    end
  end

  def shuffle
    @deck = @deck.shuffle
  end

end

run_game
