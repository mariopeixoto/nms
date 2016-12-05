require 'test_helper'

class DebtTypesControllerTest < ActionController::TestCase
  setup do
    @debt_type = debt_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debt_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debt_type" do
    assert_difference('DebtType.count') do
      post :create, debt_type: { debt_type: @debt_type.debt_type }
    end

    assert_redirected_to debt_type_path(assigns(:debt_type))
  end

  test "should show debt_type" do
    get :show, id: @debt_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debt_type
    assert_response :success
  end

  test "should update debt_type" do
    patch :update, id: @debt_type, debt_type: { debt_type: @debt_type.debt_type }
    assert_redirected_to debt_type_path(assigns(:debt_type))
  end

  test "should destroy debt_type" do
    assert_difference('DebtType.count', -1) do
      delete :destroy, id: @debt_type
    end

    assert_redirected_to debt_types_path
  end
end
