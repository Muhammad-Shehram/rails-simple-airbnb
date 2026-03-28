class AddPictureUrlToFlats < ActiveRecord::Migration[7.2]
  def change
    add_column :flats, :picture_url, :string
  end
end
