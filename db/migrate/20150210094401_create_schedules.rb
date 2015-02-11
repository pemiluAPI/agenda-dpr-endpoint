class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string  :link
      t.string  :title
      t.string  :time
      t.string  :date
    end
  end
end
