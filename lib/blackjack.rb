class Game
  def initialize
    print "Welcome to Blackjack. Would you like to play? (Y/N) "
    user_command = gets.chomp

    if user_command == "y" || user_command == ""
      @deck = Deck.new(2)
      @wallet = Wallet.new(100)
      @min_bet = 10

      play_again = ""

      until play_again == "n" || @wallet.balance < @min_bet
        set_table
        if @wallet.balance >= @min_bet
          print " | Play another hand? (Y/N)"
          play_again = gets.chomp
        end
      end
      puts "\nNot enough money!" if @wallet.balance < @min_bet
      puts "\nGame over!"
    else
      puts "\nMaybe next time. Bye!"
    end
  end

  def show_cards(player,hide_card)
    @deck.hands[player].show(hide_card)
  end

  def set_table
    @deck.shuffle
    @deck.create_seats(1)

    @wallet.bet(@min_bet)
    @wallet.print_balance

    @decision = ""

    print "\nPlayer Cards: "
    show_cards(0,false)

    if @deck.hands[0].blackjack == false && @deck.hands[-1].blackjack == false
      print "\nDealer Cards: "
      show_cards(1,true)

      until @decision == "s" || @deck.hands[0].value >= 21
        print "\n\n(H)it or (S)tand? "
        @decision = gets.chomp
        hit(0) if @decision == "h" || @decision == ""
      end
    end

    dealer
    eval_turn(0)
    @wallet.print_balance

  end

  def hit(player)
      print "\nPlayer Cards: "
      @deck.hands[player].add_card(@deck.deal)
      @deck.hands[player].show(false)
  end

  def eval_turn(player)
    if @deck.hands[player].value > 21
      if @deck.hands[-1].value > 21
        result_push
      else
        result_lose
      end
    elsif @deck.hands[player].blackjack == true
      if @deck.hands[-1].blackjack == true
        result_push
      else
        result_win
      end
    elsif @deck.hands[player].value == @deck.hands[-1].value
      if @deck.hands[-1].blackjack == true
        result_lose
      else
        result_push
      end
    elsif @deck.hands[player].value < @deck.hands[-1].value
      if @deck.hands[-1].value > 21
        result_win
      else
        result_lose
      end
    else
      result_win
    end
  end

  def dealer
    print "\nDealer Cards: "
    if @deck.hands[-1].blackjack == true
      @deck.hands[-1].show(true)
    else
      until @deck.hands[-1].value  >= 17
        @deck.hands[-1].add_card(@deck.deal)
      end
      @deck.hands[-1].show(false)
    end
  end

  def result_push
    @wallet.add(@wallet.wager)
    print "\n\nPush!"
  end

  def result_win
    winnings = @wallet.wager * 2
    winnings += @wallet.wager * 0.5 if @deck.hands[0].blackjack == true
    @wallet.add(winnings)
    print "\n\nPlayer wins!"
  end

  def result_lose
    print "\n\nYou lose!"
  end

end

class Wallet
  attr_accessor :balance, :wager

  def initialize(initial_money)
    @balance = initial_money.to_i
  end

  def bet(wager)
    @wager = wager
    @balance -= @wager
    print "\nWager: $#{@wager}"
  end

  def add(winnings)
    @balance += winnings.to_i
  end

  def print_balance
    print " | Remaining Money: $#{@balance}"
  end

end

class Hand
  attr_reader :hand, :value, :blackjack

  def initialize
    @hand = []
    @blackjack = false
  end

  def add_card(dealt_card)
    @hand << dealt_card
    value
  end

  def show(hide_card)
    @hide_card = hide_card
    @hand.each do |card|
      if @hide_card == true
        print "[hidden card] "
        @hide_card = false
      else
        print "[#{card.face} of #{card.suit}] "
      end
    end

    if hide_card == false
      print "| Value: #{@value} "
      print "- BLACKJACK!" if @blackjack == true
      print "- BUST!" if @value > 21
    end

  end

  def value
    @face_value_pair = {"ace"=>[1,11],"2"=>2,"3"=>3,"4"=>4,"5"=>5,"6"=>6,"7"=>7,
      "8"=>8,"9"=>9,"10"=>10,"jack"=>10,"queen"=>10,"king"=>10}

    2.times do
      @value = 0
      @hand.each do |card|
        if card.face != "ace"
          @value += @face_value_pair[card.face]
        else
          @value += 1
          @value += 10 if (@value + 10) <= 21
        end
      end
    end

    if @value == 21 && @hand.length == 2
      @blackjack = true
    end

    @value
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
    @faces = ["ace","2","3","4","5","6","7","8","9","10","jack","queen","king"]
    @deck = []

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
        @hands[seat].value
      end
    end

  end

  def shuffle
    @deck = @deck.shuffle
  end

end

game = Game.new
