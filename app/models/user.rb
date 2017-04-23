class User < ApplicationRecord
	has_many :timelogs
	has_many :projects, foreign_key: "created_by"
	has_many :collaborations, foreign_key: "collaborator_id"


	 validates :first_name, presence: true, length: { minimum: 1 }
	 validates :last_name, presence: true, length: { minimum: 1 }
	 validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
	 validates :password, presence: true, confirmation: true, length: { minimum: 4 }
	 validates :password_confirmation, presence: true
end