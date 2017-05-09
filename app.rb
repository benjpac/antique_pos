require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @items = Item.all()
  @purchases = Purchase.all()
  erb :index
end

post '/item' do
  name = params[:name]
  price = convert_to_cents(params[:price])
  item = Item.create({:name => name, :price => price})
  # if item.save()
  #
  # end

  @items = Item.all()
  @purchases = Purchase.all()
  erb :index
end

post '/purchase' do
  customer = params["customer"]
  purchase = Purchase.create({:customer => customer})
  item_ids = params.fetch("item_ids", [])
  item_ids.each() do |item_id|
    item = Item.find(item_id)
    item.update({:purchase_id => purchase.id()})
  end
  @items = Item.all()
  @purchases = Purchase.all()
  erb :index
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
