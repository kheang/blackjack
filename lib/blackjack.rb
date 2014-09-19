def run_game
  game = Game.new
end

class Game
  def initialize
    # @shoe = Shoe.new(2).shuffle
    # @wallet = Wallet.new(100)
    # @wager_amt = 10
    # # @num_players = 1
    # # create_seats(@num_players)
    #
    # clear
    puts "~ Blackjack ~"

    puts "Welcome to Blackjack. Would you like to play? (yes/no)"

    # while
    #   user_command = gets.chomp
    #   puts ""
    #   break if user_command == "no"
    #
    #   # get_wager
    #   #
    #   # deal(2)
    #
    #   # puts "Would you like to play again? (yes/no)"
    # end
    @deck = Deck.new(2)
    @deck.shuffle
    @card = @deck.deal
    puts @card.face
    puts @card.suit

    puts "Bye!"

  end

  # def get_wager
  #   @wallet.print_balance
  #   @wallet.bet(@wager_amt)
  #   "puts"
  # end
  #
  # def create_seats(num_players)
  #   @num_players = num_players + 1
  #   @seats = [*1..@num_players]
  #   @hands = {}
  #
  #   @seats.each do |seat|
  #     @hands[seat] = []
  #   end
  # end
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
  # def clear
  #   system('clear')
  # end


end

# class Wallet
#   attr_accessor :balance
#
#   def initialize(initial_money)
#     @balance = initial_money.to_i
#   end
#
#   def bet(wager)
#     @balance -= wager
#     puts "You must bet $#{wager}. You now have $#{@balance} in chips left (excluding bet)."
#   end
#
#   def add(winnings)
#     @balance += winnings.to_i
#   end
#
#   def print_balance
#     puts "You have #{@balance}."
#   end
#
# end

# class Hand
#   attr_accessor :cards
#
#   def initialize()
#     @hand_cards = {}
#     @num_cards = 0
#   end
#
#   def get_card
#     @cards = shoe.master_deck
#     @hand_cards[@num_cards] = @cards.first
#     @num_cards += 1
#   end
#
#   def show_hand
#     @master_deck.each do |key,card|
#       card = card
#       print "# #{key}: "
#       print card.suit + ", "
#       print card.face + "; "
#     end
#   end
#
# end

class Card
  attr_reader :suit, :face

  def initialize(suit,face)
    @suit = suit
    @face = face
  end
end

class Deck
  attr_accessor :deck

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
    @dealt_card = @deck[0]
    @deck.drop(1)
    puts "Number of cards left: #{@deck.length}."
    @dealt_card
  end

  def shuffle
    @deck = @deck.shuffle
  end

end

run_game
