require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

helpers do
  def valid_money?(money)
    money.to_i > 0
  end

  def valid_name?(name)
    if name == "" then false
    elsif name.include? 'a' then true
    elsif name.include? 'e' then true
    elsif name.include? 'i' then true
    elsif name.include? 'o' then true
    elsif name.include? 'u' then true
    else
      false
    end
  end

  def calc_value(hand)
    value = 0
    total = 0
    ace = false # ask about a better way...
    if hand
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
    :'10'=> 'Ten', :'j'=> 'jack', :'q'=> 'queen', :'k'=> 'king', :'a'=> 'ace'
    }
    rank_names[rank_symbol]
  end

  def suit_name(card)
    suit_symbol = card[1].to_s.to_sym
    suit_names = {
      :'c'=>'clubs', :'d'=> 'diamonds', :'h'=> 'hearts', :'s'=> 'spades'}
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
    session[:bet] = 10
    session[:money] ||= 100
  end

  def hit
    session[:player_hand] << session[:deck].shift
  end

  def dealer_hit
    session[:dealer_hand] << session[:deck].shift
  end

  def card_image(card)
    rank = ""
    suit = ""
    if card[0].to_i == 0
      rank = rank_name(card)
    else
      rank = card[0].to_i
    end
    suit = suit_name(card)
    "<img src='/images/cards/#{suit}_#{rank}.jpg' class='card_image'/>"
  end

  def game_win
    session[:money] += session[:bet]
    @success += "<br>Congratulations! You won #{session[:bet]}$<br>You now have: #{session[:money]}$"
    @game_over = true
  end

  def game_lose
    session[:money] -= session[:bet]
    @error += "<br>Sorry...you lost #{session[:bet]}$<br>You now have: #{session[:money]}$"
    @game_over = true
  end
end

before do
   @show_hit_or_stay_buttons = true
   @show_dealer_hit_button = false
   @game_over = false
   @show_dealer_second_card = false
end

get '/' do
  if session[:name]
    erb :game
  else
    erb :ask_name
  end
end

get '/ask_name' do
  erb :ask_name
end

post '/set_name' do
  unless valid_name? params[:name]
    @error = "Valid name is required"
    halt erb :ask_name
  end

# Insert validation helper funciton here
  unless valid_money? params[:money]
    @error = "Please give a number greater than zero for starting money"
    halt erb :ask_name
  end

  session[:name] = params[:name]
  session[:money] = params[:money].to_i
  new_game
  redirect '/game'
end

get '/new_game' do
  new_game
  redirect '/game'
end

get '/game' do
  if calc_value(session[:player_hand]) == 21
    @success = "You hit Blackjack!"
    @show_hit_or_stay_buttons = false
    game_win
  end
  erb :game
end

post '/game/player/hit' do
  hit
  @player_val = calc_value(session[:player_hand])
  if @player_val > 21
    @error = "Sorry, you bust..."
    @show_hit_or_stay_buttons = false
    game_lose
  elsif @player_val == 21
    @success = "You hit blackjack!"
    @show_hit_or_stay_buttons = false
    game_win
  end

  erb :game
end

get '/game/dealer' do
  @show_dealer_second_card = true
  @dealer_val = calc_value(session[:dealer_hand])
  @show_hit_or_stay_buttons = false
  if @dealer_val < 17
    @show_dealer_hit_button = true
  elsif @dealer_val == 21
    @error = "Dealer hit blackjack"
    game_lose
  elsif @dealer_val > 21
    @success = "Dealer busts"
    game_win
  elsif @dealer_val < calc_value(session[:player_hand])
    @success = "Player's hand value is higher"
    game_win
  elsif @dealer_val >= calc_value(session[:player_hand])
    @error = "Dealer wins."
    game_lose
  else
    @error = "This condition shouldn't be reached..."
  end

  erb :game
end

post '/game/player/stay' do
  @success = "You have decided to stay"
  @show_hit_or_stay_buttons = false
  redirect '/game/dealer'
end

post '/game/dealer/hit' do
  dealer_hit
  redirect '/game/dealer'
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



