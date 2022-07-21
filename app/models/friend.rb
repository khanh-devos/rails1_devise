
# custom validation for "email"
class CheckEmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
            record.errors.add attribute, (options[:message] || "is not an email")
        end
    end
end 


class Friend < ApplicationRecord
    include Visible         #for concerns

        belongs_to :user

    has_one_attached :avatar do |attachable|
        attachable.variant :thumb, resize_to_limit: [100, 100]
    end

    validates :first_name, presence: true, length: { minimum: 2 }
    
    validates :email, uniqueness: true, checkEmail: true   
    
    validates :check, acceptance: true      #only accept true

    after_create :action_after_create, :rezise_after_create
    
    private
    def action_after_create
        
        self.update(phone: "callbacks 12345")

        #check unique
        # if Friend.where(email: self.email).size >1
        #     puts "#{self.email} was duplicated." 
        #     self.destroy
        # end
        #throw(:abort) if Friend.where(email: self.email).size >1

    end

    def rezise_after_create
        p "resize"
    end
end


