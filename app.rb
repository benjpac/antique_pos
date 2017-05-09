require("bundler/setup")
Bundler.require(:default)
also_reload('lib/**/*.rb')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @items = Item.all()
  @purchases = Purchase.all()
  erb :index
end

post '/item' do
  name = params[:name]
  price = convert_to_cents(params[:price])
  @item = Item.create({:name => name, :price => price})
  if @item.save()
    @items = Item.all()
    @purchases = Purchase.all()
    erb :index
  else
    erb :errors
  end
end

get '/receipt/:purchase_id' do
  purchase_id = params[:purchase_id]
  @purchase = Purchase.find(purchase_id)
  erb :receipt
end

post '/purchase' do
  customer = params["customer"]
  item_ids = params.fetch("item_ids", [])
  @purchase = Purchase.buy(customer, item_ids)
  erb :receipt
end

patch '/return' do
  item_ids = params.fetch("item_ids", [])
  item_ids.each() do |item_id|
    item = Item.find(item_id)
    new_total = item.purchase().total_price() - item.price()
    item.purchase().update({:total_price => new_total})
    item.update({:purchase_id => nil})
  end
  @items = Item.all()
  @purchases = Purchase.all()
  erb :index
end

get '/manage' do
  @items = Item.all()
  @purchases = Purchase.all()
  erb :manage
end

post '/find_purchases_by_date' do
  start_date = params[:start_date]
  end_date = params[:end_date]
  @purchase_range = Purchase.created_between(start_date, end_date)
  @items = Item.all()
  @purchases = Purchase.all()
  erb :manage
end

delete '/clear_all' do
  clear_all()
  @items = Item.all()
  @purchases = Purchase.all()
  erb :index
end

def convert_to_cents(string)
  string.tr!("$", "")
  if string.include?(".")
    string.tr!(".", "")
    return string.to_i()
  else
    return string.to_i() * 100
  end
end

def convert_to_money(cents)
  string = "$" + cents.to_s()
  return string.insert(-3, ".")
end

def clear_all
  Item.delete_all()
  Purchase.delete_all()
end
