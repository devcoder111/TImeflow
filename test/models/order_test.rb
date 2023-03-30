# == Schema Information
#
# Table name: ORDERS
#
#  delivery_type :string           not null
#  timestamp     :datetime         not null
#  value         :integer          not null
#  customer_id   :integer          not null
#  order_id      :integer          not null
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
