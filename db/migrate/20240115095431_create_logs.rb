class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.json :request
      t.json :response
      t.json :headers
      t.string :url

      t.timestamps
    end
  end
end
