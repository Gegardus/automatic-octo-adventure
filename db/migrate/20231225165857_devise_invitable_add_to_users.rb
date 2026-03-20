# frozen_string_literal: true

class DeviseInvitableAddToUsers < ActiveRecord::Migration[7.0]
  def up
    change_table :users do |t|
      t.string     :invitation_token
      t.datetime   :invitation_created_at
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.references :invited_by, polymorphic: true
      t.integer    :invitations_count
      t.index      :invitation_token, unique: true # for invitable
      t.index      :invited_by_id
    end
    remove_check_constraint :users, <<-SQL.squish
      (role <> 'applicant') OR
      (phone IS NOT NULL AND marital_status IS NOT NULL AND date_of_birth IS NOT NULL)
    SQL
    add_check_constraint :users, <<-SQL.squish
      (role <> 'applicant') OR
      (invited_by_id IS NOT NULL OR invitation_accepted_at IS NULL) OR
      ((invited_by_id IS NOT NULL OR invitation_accepted_at IS NOT NULL) AND
      (phone IS NOT NULL AND marital_status IS NOT NULL AND date_of_birth IS NOT NULL))
    SQL
  end

  def down
    remove_check_constraint :users, <<-SQL.squish
      (role <> 'applicant') OR
      (invited_by_id IS NOT NULL OR invitation_accepted_at IS NULL) OR
      ((invited_by_id IS NOT NULL OR invitation_accepted_at IS NOT NULL) AND
      (phone IS NOT NULL AND marital_status IS NOT NULL AND date_of_birth IS NOT NULL))
    SQL
    add_check_constraint :users, <<-SQL.squish
      (role <> 'applicant') OR
      (phone IS NOT NULL AND marital_status IS NOT NULL AND date_of_birth IS NOT NULL)
    SQL
    change_table :users do |t|
      t.remove_references :invited_by, polymorphic: true
      t.remove :invitations_count, :invitation_limit, :invitation_sent_at, :invitation_accepted_at, :invitation_token,
               :invitation_created_at
    end
  end
end
