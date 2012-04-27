module MigrationHelpers
  def add_foreign_key(from_table, to_table, foreign_key, key)
    constraint_name = "fk_#{from_table}_#{foreign_key}"
  execute %{ALTER TABLE #{from_table}
    ADD  CONSTRAINT #{constraint_name}
    FOREIGN KEY #{to_table} (#{foreign_key})
    REFERENCES #{to_table} (#{key})}
  end

  def remove_foreign_key(from_table, foreign_key)
    constraint_name = "fk_#{from_table}_#{foreign_key}"
    execute %{alter table #{from_table} drop foreign key #{constraint_name}}
  end
end
