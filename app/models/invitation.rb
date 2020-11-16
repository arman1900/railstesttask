class Invitation < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => [:worker_id]
  
  def self.reacted?(id1, id2)
    case1 = !Invitation.where(user_id: id1, worker_id: id2).empty?
    case2 = !Invitation.where(user_id: id2, worker_id: id1).empty?
    case1 || case2 
  end
  def self.confirmed_record?(id1, id2)
    case1 = !Invitation.where(user_id: id1, worker_id: id2, confirmed: true).empty?
    case2 = !Invitation.where(user_id: id2, worker_id: id1, confirmed: true).empty?
    case1 || case2 
  end
end
