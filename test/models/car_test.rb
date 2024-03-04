require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test "should not save the car without fuel" do
    car = Car.new
    assert_not car.save, "Saved the article without a title"
  end
end
