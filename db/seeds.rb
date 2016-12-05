# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Debt types
condo_fee = DebtType.find_or_create_by!(debt_type: 'Condo Fee')
extra_fee = DebtType.find_or_create_by!(debt_type: 'Extra Fee')

#Indexations
igpm = Indexation.find_or_create_by!(name: 'IGPM') { |i| i.tpa_id = 189 }
inpc = Indexation.find_or_create_by!(name: 'INPC') { |i| i.tpa_id = 188 }

sep = Date.new(2016, 9, 1)
aug = Date.new(2016, 8, 1)
jul = Date.new(2016, 7, 1)

#Indexation values
IndexationValue.find_or_create_by!(indexation: igpm, month: jul) { |iv| iv.value = 0.15 }
IndexationValue.find_or_create_by!(indexation: igpm, month: aug) { |iv| iv.value = 0.32 }
IndexationValue.find_or_create_by!(indexation: igpm, month: sep) { |iv| iv.value = 0.79 }

IndexationValue.find_or_create_by!(indexation: inpc, month: jul) { |iv| iv.value = 0.21 }
IndexationValue.find_or_create_by!(indexation: inpc, month: aug) { |iv| iv.value = 0.39 }
IndexationValue.find_or_create_by!(indexation: inpc, month: sep) { |iv| iv.value = 0.74 }

#Condos
bali = Condominium.find_or_create_by!(name: 'Bali') { |c| c.indexation = igpm }
another_condo = Condominium.find_or_create_by!(name: 'Another Condo') { |c| c.indexation = inpc }

#Owners
john = Owner.find_or_create_by!(name: 'John Doe') { |o| o.address = '225 Research Blvd, Austin, TX' }
elias = Owner.find_or_create_by!(name: 'Elias Benny') { |o| o.address = '200 Research Blvd, Austin, TX' }

#Units
n_101 = Unit.find_or_create_by!(number: '101', condominium: bali) do |u|
  u.building = 'North Tower'
  u.owner = john
end

n_102 = Unit.find_or_create_by!(number: '102', condominium: bali) do |u|
  u.building = 'North Tower'
  u.owner = elias
end

b_101 = Unit.find_or_create_by!(number: '101', condominium: another_condo) do |u|
  u.building = 'Building Name'
  u.owner = elias
end

#Notices
notice = Notice.find_or_create_by!(name: 'Elias Benny') do |n|
  n.generated_pdf_path = 'path/to/file.pdf'
  n.address = '1139 Mopac Blvd. Austin, TX'
end

#Debts
Debt.find_or_create_by!(unit: n_101, debt_type: condo_fee, due_date: aug) do |d|
  d.description = 'Condo Fee August/2016'
  d.original_amount = 1315.00
end

Debt.find_or_create_by!(unit: n_101, debt_type: condo_fee, due_date: sep) do |d|
  d.description = 'Condo Fee September/2016'
  d.original_amount = 1315.00
end

Debt.find_or_create_by!(unit: b_101, debt_type: extra_fee, due_date: aug) do |d|
  d.description = 'Extra Fee August/2016'
  d.original_amount = 105.00
end

Debt.find_or_create_by!(unit: n_101, debt_type: condo_fee, due_date: sep) do |d|
  d.description = 'Condo Fee September/2016'
  d.original_amount = 1315.00
  d.notice = notice
end
