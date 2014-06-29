def display_hand(cards)
  cards.map {|card| card = "The #{rank_name(card)} of #{suit_name(card)}"}
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

deck = init_deck.shuffle
player_hand = []
player_hand << deck.shift
player_hand << deck.shift

puts display_hand(player_hand)



