# 1. We need a Product so we actually have something to order
# 2. We need a User so we know who ordered a Product
# 3. We need to be able to create an Order and connect/associate it with the User
# 4. We need to associate the Order with a Product using a join table that we will call OrderItem
# 5. Ideally the response should include the order and order items, so that this info can be used on the client side
#    (the minuimum is to iclude the order id in the response)

RSpec.describe 'POST /api/orders', type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  subject { response }
  before do
    post '/api/orders', params: {
      order: {
        product_id: product.id, user_id: user.id
      }
    }
    @order = Order.last
  end

  it { is_expected.to have_http_status :created }

  it 'is expected to create an instance of Order' do
    expect(@order).to_not eq nil
  end

  it 'is expected to associate order with user' do
    expect(@order.user).to eq user
  end

  it 'is expected to create an order_item' do
    expect(@order.items).to_not eq nil
  end

  it 'is expected to associate the product with the order' do
    expect(@order.products.first).to eq product
  end

  it 'is expected to include the ID of the order in the response body' do
    response_body = JSON.parse(response.body)
    expect(response_body['order']['id']).to eq @order.id
  end
end
