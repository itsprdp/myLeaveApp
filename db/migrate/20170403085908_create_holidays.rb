# frozen_string_literal: true

class CreateHolidays < ActiveRecord::Migration[5.0]
  def change
    create_table :holidays do |t|
      t.date :date
      t.string :occasion

      t.timestamps
    end
  end
end
