class Friend < ApplicationRecord
    belongs_to :user

    validates :email, presence: true, length: { minimum: 10 }

end
