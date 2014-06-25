require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

helpers do

  def calc_value(hand)
    value = 0
    total = 0
    ace = false # ask about a better way...
    hand.each do |card|
      if card[0] == 'j' || card[0] == 'q' || card[0] == 'k'
        value = 10
      elsif card[0] == 'a'
        value = 1
        ace = true
      else
        value = card[0].to_i
      end
        total += value
    end
    # aces count as 11 when it would be beneficial for them to do so
    total += 10 if ace == true && total < 12
    total
  end

  def init_deck
    cards = []
    ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'j','q','k','a']
    suits = [ 'c', 'd', 'h', 's' ]
    ranks.each do |rank|
      suits.each do |suit|
        cards << [rank, suit]
      end
    end
    return cards
  end

  def rank_name(card)
    rank_symbol = card[0].to_s.to_sym
    rank_names = {
    :'2'=> 'Two', :'3'=> 'Three', :'4'=> 'Four', :'5'=> 'Five',
    :'6'=> 'Six', :'7'=> 'Seven', :'8'=> 'Eight', :'9'=> 'Nine',
    :'10'=> 'Ten', :'j'=> 'Jack', :'q'=> 'Queen', :'k'=> 'King', :'a'=> 'Ace'
    }
    rank_names[rank_symbol]
  end

  def suit_name(card)
    suit_symbol = card[1].to_s.to_sym
    suit_names = {
      :'c'=>'Clubs', :'d'=> 'Diamonds', :'h'=> 'Hearts', :'s'=> 'Spades'}
    suit_names[suit_symbol]
  end

  def show_card_text(card)
    "The #{rank_name(card)} of #{suit_name(card)}"
  end

  def display_hand(cards)
    result = []
    cards.each do |card|
      result << "The #{rank_name(card)} of #{suit_name(card)}"
    end
    return result
  end

  def new_game
    session[:deck] = init_deck.shuffle!
    session[:player_hand] = []
    session[:player_hand] << session[:deck].shift
    session[:player_hand] << session[:deck].shift
    session[:dealer_hand] = []
    session[:dealer_hand] << session[:deck].shift
    session[:dealer_hand] << session[:deck].shift
  end

  def hit
    session[:player_hand] << session[:deck].shift
  end
end

get '/' do
  if session[:name]
    erb :game
  else
    erb :ask_name
  end
end

#When web app first loads ensure session has 'username' set.
#If not, redirect to a form to set the username.
post '/new_game' do
  new_game
  redirect '/game'
end

post '/set_name' do
  session[:name] = params[:name]
  redirect '/game'
end

get '/game' do
  # Set initial game state
  erb :game
end

post '/hit' do
  hit
  erb :game
end

post '/stay' do
  erb :game
end

######################################################
# Structure Notes
#
######################################################
#
#We'll need to do many of the same kinds of things:
# Make a deck of cards
# Create hands for player and dealer
#
# We'll also have to create betting
# Have a persistent session variable representing money
#
# Persistent (session) variables
# money
# player hand DONE
# dealer hand DONE
# deck DONE
#
# Remember the MVC model. Let's think about creating this welcome in those terms.
# It seems to me to make the most sense to start with our model, then create controllersm
# then finally the views.
#
# Model:
# That'll just be these session variables. Let's initiate them, and create some helper
# methods that allow us to manipulate them
#
# Controller: (actions)
# Players and dealers can be dealt cards
# Players can bet
# Gameplay
#
#Tasks:
# Include helper function to calculate total
# Implement basic gameplay
# Change view based on game state
#
#



