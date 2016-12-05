Rails.application.routes.draw do

  get '/condos' => 'queries#list_condos', as: :list_condos
  get '/units' => 'queries#list_units', as: :list_units
  get '/owner_info' => 'queries#owner_info', as: :owner_info
  get '/unit_debts' => 'queries#unit_debts', as: :unit_debts
  get '/unit_outstanding_debt' => 'queries#unit_outstanding_debt', as: :unit_outstanding_debt
  get '/condo_outstanding_debt' => 'queries#condo_outstanding_debt', as: :condo_outstanding_debt
  get '/sum_indexations' => 'queries#sum_indexations', as: :sum_indexations
  get '/condo_units' => 'queries#condo_units', as: :condo_units
  get '/owner_units' => 'queries#owner_units', as: :owner_units
  get '/condo_owners' => 'queries#condo_owners', as: :condo_owners
  get '/sum_indexation_from_date' => 'queries#sum_indexation_from_date', as: :sum_indexation_from_date
  get '/owners' => 'queries#list_owners', as: :list_owners
  get '/units_in_debt' => 'queries#units_in_debt', as: :units_in_debt
  get '/owners_debt' => 'queries#owners_debt', as: :owners_debt
  get '/owner_notices' => 'queries#owner_notices', as: :owner_notices

  root 'application#index'

end
