class Case < ApplicationRecord
    has_one                 :user
    has_many                :rooms

    has_many_attached       :videos

    after_create :mailer_new_case

    validates :title, presence: true, length: { minimum: 5, maximum: 140 }
    validates :case_reference, presence: true, length: { minimum: 5, maximum: 140 }
    validates :contact_referent, presence: true, length: { minimum: 25, maximum: 500 }
    validates :street_number, presence: true, length: { minimum: 1, maximum: 10 }
    validates :street_name, presence: true, length: { minimum: 3, maximum: 140 }
    validates :city, presence: true
    validates :zipcode, presence: true, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "Entrer un code postal français valide" }
    # validates :visit_date, presence: true, if: :past_date
    # validates :physical_description, length: {in: 1...500}
    # validates :geographical_description, length: {in: 1...500}
    # validates :potential_description, length: {in: 1...500}

	# numericality: {greater_than_or_equal_to: 1}
    # presence: true, numericality: {greater_than_or_equal_to: 1}, if: :multiple_of_five?
    # presence: true, length: { minimum: 20, maximum: 1000 },
    # presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, only_integer: true }
  
    private
  
    def past_date
      errors.add(:visit_date, "Vous ne pouvez rentrer une date future") unless
        visit_date <= DateTime.now
    end

    def mailer_new_case
        AdminMailer.new_case(self).deliver_now
    end
    # def multiple_of_five?
    #   errors.add(:duration, "should be a multiple of 5.") unless duration % 5 == 0
    # end 

end
