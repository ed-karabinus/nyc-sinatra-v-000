class LandmarksController < ApplicationController
  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'landmarks/edit'
  end

  get '/landmarks/:id' do 
    @landmark = Landmark.find_by(id: params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks' do
    erb :'landmarks/index'
  end

  post '/landmarks/:id' do 
    @landmark = Landmark.find_by(id: params[:id])
    @landmark.update(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    erb :'landmarks/show'
  end
end
