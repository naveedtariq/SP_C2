module MigrationHelpers
  def add_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"

    execute %{alter table #{to_table} add constraint #{constraint_name}}
  end

  def remove_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"

    execute %{alter table #{to_table} drop foreign key #{constraint_name}}

  end
end
