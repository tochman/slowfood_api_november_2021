# 1. We need a Product so we actually have something to order
# 2. We need a User so we know who ordered a Product
# 3. We need to be able to create an Order and connect/associate it with the User
# 4. We need to associate the Order with a Product using a join table that we will call OrderItem

RSpec.describe 'POST /api/orders', type: :request do
  let(:user) { create(:user) }
  subject { response }
  before do
    post '/api/orders', params: {
      order: {
        product_id: 1, user_id: user.id
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
end
