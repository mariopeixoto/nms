require 'test_helper'

class CondominiaControllerTest < ActionController::TestCase
  setup do
    @condominium = condominia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:condominia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create condominium" do
    assert_difference('Condominium.count') do
      post :create, condominium: { fine_pct: @condominium.fine_pct, indexation_id: @condominium.indexation_id, interest_pct: @condominium.interest_pct, name: @condominium.name }
    end

    assert_redirected_to condominium_path(assigns(:condominium))
  end

  test "should show condominium" do
    get :show, id: @condominium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @condominium
    assert_response :success
  end

  test "should update condominium" do
    patch :update, id: @condominium, condominium: { fine_pct: @condominium.fine_pct, indexation_id: @condominium.indexation_id, interest_pct: @condominium.interest_pct, name: @condominium.name }
    assert_redirected_to condominium_path(assigns(:condominium))
  end

  test "should destroy condominium" do
    assert_difference('Condominium.count', -1) do
      delete :destroy, id: @condominium
    end

    assert_redirected_to condominia_path
  end
end
