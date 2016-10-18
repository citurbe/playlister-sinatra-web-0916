require 'rack-flash'

class SongController < ApplicationController
      enable :sessions
      use Rack::Flash


  get '/songs' do
    erb :"/songs/index"
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :"/songs/show"
  end

  post '/songs' do

    if params[:artist_name] != "" && params[:artist] == nil
      artist = Artist.find_or_create_by(name:params[:artist_name])

    else
      artist = Artist.find_by_slug(params[:artist])
    end
    genres = []
      if params[:genres] != nil
        genres = params[:genres].map do |genre_id|
          Genre.find(genre_id)
        end
      end

      if params[:genre_name] != ""
        new_genre = Genre.create(name:params[:genre_name])
        genres << new_genre
      end

      @new_song = Song.create(name:params[:name], artist:artist, genres:genres)
      flash[:message] = "Successfully created song."
      redirect "songs/#{@new_song.slug}"

  end

  patch "/songs/:slug" do


    if params[:artist_name] == ""
      artist = Artist.find_by_slug(params[:artist])
    else
      artist = Artist.find_or_create_by(name:params[:artist_name])



    end
    
    genres = []
      if params[:genres] != nil
        genres = params[:genres].map do |genre_id|
          Genre.find(genre_id)
        end
      end

      if params[:genre_name] != ""
        new_genre = Genre.create(name:params[:genre_name])
        genres << new_genre
      end
      song = Song.find_by_slug(params[:slug])
      song.update(name:params[:name],artist:artist,genres:genres)
      song.save
      flash[:message] = "Successfully updated song."
      redirect "/songs/#{params[:slug]}"


  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end


end
