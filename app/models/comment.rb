class Comment < ApplicationRecord
  mount_uploader :image, CommentUploader
  belongs_to :user
  belongs_to :trip
end
