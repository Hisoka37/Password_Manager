class UserPassword < ApplicationRecord
  ROLES= %w{owner viewer editor}
  belongs_to :user
  belongs_to :password

  validates :role, presence: true, inclusion: {in: ROLES}

  def owner?
    role == 'owner'
  end

  def viewer? 
    role == 'viewer'
  end

  def editor?
    role == 'editor'
  end

  def editable
    owner? || editor?
  end

  def shareable 
    owner? 
  end

end
