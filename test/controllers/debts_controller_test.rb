require 'test_helper'

class DebtsControllerTest < ActionController::TestCase
  setup do
    @debt = debts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debt" do
    assert_difference('Debt.count') do
      post :create, debt: { debt_type_id: @debt.debt_type_id, description: @debt.description, due_date: @debt.due_date, notice_id: @debt.notice_id, original_amount: @debt.original_amount, paid: @debt.paid, unit_id: @debt.unit_id }
    end

    assert_redirected_to debt_path(assigns(:debt))
  end

  test "should show debt" do
    get :show, id: @debt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debt
    assert_response :success
  end

  test "should update debt" do
    patch :update, id: @debt, debt: { debt_type_id: @debt.debt_type_id, description: @debt.description, due_date: @debt.due_date, notice_id: @debt.notice_id, original_amount: @debt.original_amount, paid: @debt.paid, unit_id: @debt.unit_id }
    assert_redirected_to debt_path(assigns(:debt))
  end

  test "should destroy debt" do
    assert_difference('Debt.count', -1) do
      delete :destroy, id: @debt
    end

    assert_redirected_to debts_path
  end
end
