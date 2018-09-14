class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def editable_attributes
    exceptions = %w(id created_at updated_at)
    self.attributes.reject{ |k, v| exceptions.include?(k) }
      #.map { |val| val.to_str }
  end

end
