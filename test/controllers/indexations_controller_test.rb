require 'test_helper'

class IndexationsControllerTest < ActionController::TestCase
  setup do
    @indexation = indexations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:indexations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create indexation" do
    assert_difference('Indexation.count') do
      post :create, indexation: { name: @indexation.name, tpa_id: @indexation.tpa_id }
    end

    assert_redirected_to indexation_path(assigns(:indexation))
  end

  test "should show indexation" do
    get :show, id: @indexation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @indexation
    assert_response :success
  end

  test "should update indexation" do
    patch :update, id: @indexation, indexation: { name: @indexation.name, tpa_id: @indexation.tpa_id }
    assert_redirected_to indexation_path(assigns(:indexation))
  end

  test "should destroy indexation" do
    assert_difference('Indexation.count', -1) do
      delete :destroy, id: @indexation
    end

    assert_redirected_to indexations_path
  end
end
