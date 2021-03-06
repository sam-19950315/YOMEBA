class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader

  belongs_to :genre, optional: true, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :read_book_logs, dependent: :destroy

  validates :nickname, presence: true, length: { maximum: 20 }

  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end

  def active_for_authentication?  
    super && !deleted_at  
  end  

  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end 


end
