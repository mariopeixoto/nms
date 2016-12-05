class QueriesController < ApplicationController

  def list_condos
    @condos = Condominium.all
  end

  def list_units
    @condo_id = params[:condo_id]
    if @condo_id.present?
      @units = Unit.joins(:condominium)
        .where('condominia.id = ?', @condo_id)
    end
  end

  def owner_info
    @owner = nil

    @condo_name = params[:condo_name]
    @unit_number = params[:unit_number]
    if @condo_name.present? and @unit_number.present?
      owners = execute_statement "select o.* from owners o
        inner join units u on o.id = u.owner_id
        inner join condominia c on u.condominium_id = c.id
        where c.name = '#{@condo_name}' and u.number = '#{@unit_number}'"

      @owner = Owner.new(owners.first) unless owners.empty?
    end
  end

  def unit_debts
    @debts = []

    @condo_name = params[:condo_name]
    @unit_number = params[:unit_number]
    if @condo_name.present? and @unit_number.present?
      @debts = execute_statement("select d.* from debts d
        inner join units u on d.unit_id = u.id
        inner join condominia c on u.condominium_id = c.id
        where c.name = '#{@condo_name}' and u.number = '#{@unit_number}'").collect {|d| Debt.new(d)}
    end
  end

  def unit_outstanding_debt
    @condo_name = params[:condo_name]
    @unit_number = params[:unit_number]
    if @condo_name.present? and @unit_number.present?
      @outstanding_debt = execute_statement("select
          sum(
            d.original_amount +
            (d.original_amount*c.fine_pct/100) +
            ((c.interest_pct/30)*(current_date - d.due_date)) +
            d.original_amount*
              (
                select sum(iv.value) from indexation_values iv
                join indexations i on i.id = iv.indexation_id
                where i.id = c.indexation_id
                and iv.month between d.due_date and current_date
              )/100
            ) as outstandingDebt
        from debts d
        inner join units u on d.unit_id = u.id
        inner join condominia c on u.condominium_id = c.id
        where c.name = '#{@condo_name}' and u.number = '#{@unit_number}'
          and d.paid = false").first['outstandingDebt']
    end
  end

  def condo_outstanding_debt
    @condo_name = params[:condo_name]
    if @condo_name.present?
      @outstanding_debt = execute_statement("select
        sum(
          d.original_amount +
          (d.original_amount*c.fine_pct/100) +
          ((c.interest_pct/30)*(current_date - d.due_date)) +
          d.original_amount*
            (
              select sum(iv.value) from indexation_values iv
              join indexations i on i.id = iv.indexation_id
              where i.id = c.indexation_id
              and iv.month between d.due_date and current_date
            )/100
          ) as outstandingDebt
      from debts d
      inner join units u on d.unit_id = u.id
      inner join condominia c on u.condominium_id = c.id
      where c.name = '#{@condo_name}' and d.paid = false").first['outstandingDebt']
    end
  end

  def sum_indexations
    @sum_indexations = execute_statement "select
      i.name, sum(iv.value) as value from indexation_values iv
      inner join indexations i on i.id = iv.indexation_id
      group by i.name"
  end

  def condo_units
    @condo_name = params[:condo_name]
    if @condo_name.present?
      @units = Unit.joins(:condominium)
        .where('condominia.name LIKE ?', "#{@condo_name}%")
    end
  end

  def owner_units
    @owner_name = params[:owner_name]
    if @owner_name.present?
      @units = Unit.joins(:owner)
        .where('owners.name LIKE ?', "%#{@owner_name}%")
    end
  end

  def condo_owners
    @condo_name = params[:condo_name]
    if @condo_name.present?
      @owners = execute_statement("select o.* from owners o
        inner join units u on u.owner_id = o.id
        inner join condominia c on c.id = u.condominium_id
        where c.name = '#{@condo_name}'").collect {|o| Owner.new(o) }
    end
  end

  def sum_indexation_from_date
    @indexation_name = params[:indexation_name]
    @month = params[:month]
    @year = params[:year]
    if @indexation_name.present? and @month.present? and @year.present?
      @sum_indexation = execute_statement("select sum(iv.value) as sumIndexation from indexation_values iv
        inner join indexations i on i.id = iv.indexation_id
        where i.name = '#{@indexation_name}' and iv.month between '#{@year}-#{@month}-1'
          and current_date").first['sumIndexation']
    end
  end

  def list_owners
    @owners = Owner.all
  end

  def units_in_debt
    @months = params[:months]
    @dollars = params[:dollars]

    if @months.present? and @dollars.present?
      @units = execute_statement("select * from
         (
            select u.id, sum(
              d.original_amount +
              (d.original_amount*c.fine_pct/100) +
              ((c.interest_pct/30)*(current_date - d.due_date)) +
              d.original_amount*
              (
                select sum(iv.value) from indexation_values iv
                join indexations i on i.id = iv.indexation_id
                where i.id = c.indexation_id
                and iv.month between d.due_date and current_date
              )/100
          ) as outstandingDebt from debts d
        inner join units u on d.unit_id = u.id
        join condominia c on u.condominium_id = c.id
        inner join owners o on o.id = u.owner_id
        where (current_date - d.due_date) >= #{@months.to_i*30}
        	and d.paid = false
        group by u.id) as unitsInDebt
        where outstandingDebt > #{@dollars}").collect {|u| Unit.find(u['id']) }
    end
  end

  def owners_debt
    @owners_debt = execute_statement("select
        u.owner_id, sum(
          d.original_amount +
          (d.original_amount*c.fine_pct/100) +
          ((c.interest_pct/30)*(current_date - d.due_date)) +
          d.original_amount*
            (
              select sum(iv.value) from indexation_values iv
              join indexations i on i.id = iv.indexation_id
              where i.id = c.indexation_id
              and iv.month between d.due_date and current_date
            )/100
          ) as outstandingDebt
      from debts d
      inner join units u on d.unit_id = u.id
      inner join condominia c on u.condominium_id = c.id
      where d.paid = false
      group by u.owner_id").collect {|od| {owner: Owner.find(od['owner_id']), outstandingDebt: od['outstandingDebt']} }
  end

  def owner_notices
    @owner_name = params[:owner_name]
    if @owner_name.present?
      @notices = execute_statement("select n.id from notices n
        inner join debts d on n.id = d.notice_id
        inner join units u on d.unit_id = u.id
        inner join owners o on o.id = u.owner_id
        where o.name = '#{@owner_name}'").collect {|n| Notice.find(n['id'])}
    end
  end

end
