require 'test_helper'

class OutagesControllerTest < ActionController::TestCase
  
  # This should return the minimal set of attributes required to create a valid
  # Outage. As you add validations to Outage, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OutagesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outage" do
    assert_difference('Outage.count') do
      post :create, outage: {  }
    end

    assert_redirected_to outage_path(assigns(:outage))
  end

  test "should show outage" do
    outage = Outage.create! valid_attributes
    
    get :show, id: outage
    assert_response :success
  end

  test "should get edit" do
    outage = Outage.create! valid_attributes
    
    get :edit, id: outage
    assert_response :success
  end

  test "should update outage" do
    outage = Outage.create! valid_attributes
    put :update, id: outage, outage: {  }
    assert_redirected_to outage_path(assigns(:outage))
  end

  test "should destroy outage" do
    outage = Outage.create! valid_attributes
    assert_difference('Outage.count', -1) do
      delete :destroy, id: outage
    end

    assert_redirected_to outages_path
  end
end
