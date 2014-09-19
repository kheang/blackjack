def run_game
  game = Game.new
end

class Game
  def initialize
    @shoe = Shoe.new(2).shuffle
    @wallet = Wallet.new(100)
    @wager_amt = 10
    # @shoe.show_cards

    clear
    puts "~ Blackjack ~"

    puts "Welcome to Blackjack. Would you like to play? (yes/no)"

    while
      user_command = gets.chomp
      puts ""
      break if user_command == "no"

      get_wager
      deal

      # puts "Would you like to play again? (yes/no)"
    end

  puts "Bye!"

  end

  def get_wager
    @wallet.print_balance
    @wallet.bet(@wager_amt)
    "puts"
  end

  def deal

  end

  def clear
    system('clear')
  end


end

class Wallet
  attr_accessor :balance

  def initialize(initial_money)
    @balance = initial_money.to_i
  end

  def bet(wager)
    @balance -= wager
    puts "You must bet $#{wager}. You now have $#{@balance} in chips left (excluding bet)."
  end

  def add(winnings)
    @balance += winnings.to_i
  end

  def print_balance
    puts "You have #{@balance}."
  end

end


class Hand
  attr_accessor :cards

  def initialize()
    @hand_cards = {}
    @num_cards = 0
  end

  def get_card
    @cards = shoe.master_deck
    @hand_cards[@num_cards] = @cards.first
    @num_cards += 1
  end

  def show_hand
    @master_deck.each do |key,card|
      card = card
      print "# #{key}: "
      print card.suit + ", "
      print card.face + "; "
    end
  end

end

class Card
  attr_accessor :suit, :face
end

class Deck
  attr_accessor :deck

  def initialize(shoe_size)
    @suits = ["clubs","diamonds","hearts","spades"]
    @rank_value_pair = {"ace"=>[1,11],"2"=>2,"3"=>3,"4"=>4,"5"=>5,"6"=>6,"7"=>7,"8"=>8,"9"=>9,"10"=>10,"jack"=>10,"queen"=>10,"king"=>10}
    @deck = {}
    @faces = []
    @values = []
    deck_size = 1

    @rank_value_pair.each do |face,value|
      @faces << face
      @values << value
    end

    @suits.each do |suit|
      @faces.each do |face|
        @deck[shoe_size] = Card.new
        @deck[shoe_size].suit = suit
        @deck[shoe_size].face = face
        shoe_size += 1
      end
    end

    @deck
  end

end

class Shoe
  attr_accessor :master_deck

  def initialize(num_decks)
    @master_deck = {}
    @num_decks = num_decks.to_i
    deck_length = 52

    for each_deck in 0..(@num_decks - 1)
      first_card_num = 1 + each_deck * deck_length
      new_deck = Deck.new(first_card_num)
      @master_deck = @master_deck.merge(new_deck.deck)
    end

    @master_deck
  end

  def shuffle
    @shoe_length = @master_deck.length
    shoe_order = [*1..@shoe_length].shuffle
    @shuffled_shoe = {}

    for i in 1..@shoe_length
      @shuffled_shoe[i] = @master_deck[shoe_order[i-1]]
    end

    @master_deck = @shuffled_shoe
  end

  def deal
    key = @master_deck.keys[0]
    @master_deck.delete(key)
  end

  def show_cards
    @master_deck.each do |key,card|
      card = card
      print "# #{key}: "
      print card.suit + ", "
      print card.face + "; "
    end
  end

end


run_game
