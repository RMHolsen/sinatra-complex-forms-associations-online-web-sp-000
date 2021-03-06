
require "pry"
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params[:pet_name], owner_id: params.key("on"))
    #Create a pet with the params of the pet's name (don't forget to check the spec for your specific wording like name/pet_name)
    #owner_id: params.key("on") means it's taking the params key that's "on"
    #i.e. someone has selected a radio button (on) and that radio button has an id of the owner's id #
    #That becomes the key in the params hash with the value of on
    #AND DON'T FORGET ON IS A STRING
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end 
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    #binding.pry
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do 
    #Maybe the bug fix from owners_controller goes here? Maybe not?
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    #It turns out Capybara frells with radio buttons. Heh. 
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      #binding.pry
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end

#@owner = Owner.find(params[:owner_id])
    #if params[:owner_name] != @owner.name
     # @pet.owner = Owner.create(name: params[:owner_name])
      #@pet.save
    #end
    #Nope not this