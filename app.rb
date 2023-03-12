require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader'
require 'tilt/erubis'
require './rsps.rb'
require './helpers.rb'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  @game = session[:game] if active_session?
  @player_score = @game.human.score if active_session?
  @computer_score = @game.computer.score if active_session?
  @game_history = @game.game_history if active_session?
end

get '/' do
  erb :home
end

get '/newgame' do
  setup_game unless active_session?
  redirect '/gameround'
end

get '/gameround' do
  erb :newgame
end

post '/gameround' do
  @game.human.choose(params[:move])
  @game.computer.choose
  @game.add_score
  @game.update_game_history
  redirect '/roundresult'
end

get '/roundresult' do
  @human_move = @game.human.move.to_s
  @computer_move = @game.computer.move.to_s
  erb :roundresult
end

get '/newround' do
  erb :newgame
end

get '/newmatch' do
  teardown_game
  redirect '/newgame'
end

get '/quit' do
  teardown_game
  erb :goodbye
end
