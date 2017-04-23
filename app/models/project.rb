class Project < ApplicationRecord
	belongs_to :user, foreign_key: "created_by"
	has_many :collaborations
	has_many :timelogs
end
