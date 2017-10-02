class AddAttachmentCreatorImgToCreators < ActiveRecord::Migration[5.1]
  def self.up
    change_table :creators do |t|
      t.attachment :creator_img
    end
  end

  def self.down
    remove_attachment :creators, :creator_img
  end
end
