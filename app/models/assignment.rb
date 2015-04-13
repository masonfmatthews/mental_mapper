class Assignment < ActiveRecord::Base
  include CoversConcepts
  has_many :coverages, dependent: :destroy,
      foreign_key: 'assignment_id', class_name: "AssignmentCoverage"
  has_many :scores, dependent: :restrict_with_error

  validates :name, presence: true
end
