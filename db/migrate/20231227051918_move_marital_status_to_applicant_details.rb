# frozen_string_literal: true

class MoveMaritalStatusToApplicantDetails < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        remove_check_constraint :users, <<-SQL.squish
          (role <> 'applicant') OR
          (invited_by_id IS NOT NULL OR invitation_accepted_at IS NULL) OR
          ((invited_by_id IS NOT NULL OR invitation_accepted_at IS NOT NULL) AND
          (phone IS NOT NULL AND marital_status IS NOT NULL AND date_of_birth IS NOT NULL))
        SQL
        add_check_constraint :users, <<-SQL.squish
          (role <> 'applicant') OR
          (invited_by_id IS NOT NULL OR invitation_accepted_at IS NULL) OR
          ((invited_by_id IS NOT NULL OR invitation_accepted_at IS NOT NULL) AND
          (phone IS NOT NULL AND date_of_birth IS NOT NULL))
        SQL
      end

      dir.down do
        remove_check_constraint :users, <<-SQL.squish
          (role <> 'applicant') OR
          (invited_by_id IS NOT NULL OR invitation_accepted_at IS NULL) OR
          ((invited_by_id IS NOT NULL OR invitation_accepted_at IS NOT NULL) AND
          (phone IS NOT NULL AND date_of_birth IS NOT NULL))
        SQL
        add_check_constraint :users, <<-SQL.squish
          (role <> 'applicant') OR
          (invited_by_id IS NOT NULL OR invitation_accepted_at IS NULL) OR
          ((invited_by_id IS NOT NULL OR invitation_accepted_at IS NOT NULL) AND
          (phone IS NOT NULL AND marital_status IS NOT NULL AND date_of_birth IS NOT NULL))
        SQL
      end
    end

    remove_column :users, :marital_status, :string, null: false
    add_column :applicant_details, :marital_status, :string
  end
end
