class AddPaperclipToImageModel < ActiveRecord::Migration[5.0]
  def self.up
    add_attachment :images, :source
  end

  def self.down
    remove_attachment :images, :source
  end
end
