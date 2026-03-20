# frozen_string_literal: true

class CreateHomeCarousels < ActiveRecord::Migration[7.0]
  def change
    create_table :home_carousels, &:timestamps
  end
end
