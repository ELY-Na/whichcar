require 'test_helper'

class FavouritePolicyTest < ActiveSupport::TestCase
  def setup
    @user = users(:one) # Assuming you have a fixture for users
    @favourite = Favourite.new(user: @user) # Adjust as needed based on your model
  end

  def test_show
    # Test that a user can only view their own favourite
    assert FavouritePolicy.new(@user, @favourite).show?
  end

  def test_create
    # Test that a user can only create their own favourite
    assert FavouritePolicy.new(@user, @favourite).create?
  end

  def test_destroy
    # Test that a user can only destroy their own favourite
    assert FavouritePolicy.new(@user, @favourite).destroy?
  end
  
  def delete_fav_index
    assert FavouritePolicy.new(@user, @favourite).destroy?
  end
end
