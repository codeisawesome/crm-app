# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.
require_relative 'contact'
require 'sinatra'

# Temp fake data for testing purposes

Contact.create('Mark', 'Zuckerberg', 'mark@facebook.com', 'CEO')
Contact.create('Sergey', 'Brin', 'sergey@google.com', 'Co-Founder')
Contact.create('Steve', 'Jobs', 'steve@apple.com', 'Visionary')
Contact.create('Johnny', 'Bravo', 'johnny@bitmakerlabs.com', 'Rockstar')

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

post '/contacts' do
  Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
  redirect to('/contacts')
end

get '/contacts/:id' do
  @contact = Contact.find_id(params[:id].to_i)
  if @contact != nil
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
  @contact = Contact.find_id(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end
