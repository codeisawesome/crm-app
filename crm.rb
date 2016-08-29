# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.
require_relative 'contact'
require 'sinatra'

# Temp fake data for testing purposes

get '/' do
  @time = Time.now.to_date
  @crm_app_name = "Rui's CRM"
  erb :index
end

get '/contacts' do
  erb :contacts
end

get '/contacts/new' do
  erb :new_contacts
end

get '/contacts/search' do
  @contact = Contact.find_by(params[:type] => params[:search])
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

post '/contacts' do
  @contact = Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/contacts')
  # Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
  # redirect to('/contacts')
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
  @contact = Contact.find(params[:id].to_i)
    erb :edit_contact
end

put '/contacts/:id' do # handles put request
  @contact            = Contact.find(params[:id].to_i) # inside the put request, it includes the id, if we can find the id, then we can update it
  @contact.first_name = params[:first_name]
  @contact.last_name  = params[:last_name]
  @contact.email      = params[:email]
  @contact.note       = params[:note]

    redirect to('/contacts/:id')
end


delete '/contacts/:id' do
  @contact = Contact.find_by(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
  # @contact = Contact.find(params[:id].to_i)
  # if @contact
  #   @contact.delete
  #   redirect to('/contacts')
  # else
  #   raise Sinatra::NotFound
  # end
end

after do
  ActiveRecord::Base.connection.close
end
