require 'test_helper'

class FavouriteTest < ActiveSupport::TestCase
  test "favourite should be unique for each user and car" do
    user = User.create(name: "Test User")
    car = Car.create(model: "Model X")

    # Create a favourite for the user and car
    favourite = Favourite.new(user: user, car: car)
    assert favourite.valid?, "Initial favourite should be valid"
    favourite.save

    # Attempt to create another favourite with the same user and car
    duplicate_favourite = Favourite.new(user: user, car: car)

    assert_not duplicate_favourite.valid?, "Duplicate favourite should not be valid"
    assert_equal ["has already been taken"], duplicate_favourite.errors[:car], "Error message should indicate uniqueness violation"
  end
end
