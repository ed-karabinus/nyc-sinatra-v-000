require 'pry'
class FiguresController < ApplicationController
  get '/figures/new' do 
    erb :'figures/new'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/edit'
  end

  get '/figures/:id' do 
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end

  get '/figures' do 
    erb :'figures/index'
  end

  post '/figures/:id' do 
    @figure = Figure.find_by(id: params[:id])
    @figure.update(name: params["figure"]["name"])
    params["figure"]["title_ids"].each do |title_index|
      FigureTitle.create(title_id: title_index.to_i, figure_id: @figure.id)
    end if params["figure"]["title_ids"]
    params["figure"]["landmark_ids"].each do |landmark_index|
      @figure.landmarks << Landmark.find_by(id: landmark_index.to_i)
      @figure.save
    end if params["figure"]["landmark_ids"]
    unless !params["landmark"]["name"] || params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.save
    end
    unless !params["landmark"]["name"] || params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      FigureTitle.create(title_id: title.id, figure_id: @figure.id)
    end
    erb :'figures/show'
  end

  post '/figures' do 
    @figure = Figure.create(name: params["figure"]["name"])
    params["figure"]["title_ids"].each do |title_index|
      FigureTitle.create(title_id: title_index.to_i, figure_id: @figure.id)
    end if params["figure"]["title_ids"]
    params["figure"]["landmark_ids"].each do |landmark_index|
      @figure.landmarks << Landmark.find_by(id: landmark_index.to_i)
      @figure.save
    end if params["figure"]["landmark_ids"]
    unless !params["landmark"]["name"] || params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.save
    end
    unless !params["landmark"]["name"] || params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      FigureTitle.create(title_id: title.id, figure_id: @figure.id)
    end
    erb :'figures/show'
  end
end