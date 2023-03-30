class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  SQL_OPERATORS = {
    'Equal to' => '=', 
    'Greater than' => '>', 
    'Less than' => '<', 
    'Greater than or equal to' => '>=', 
    'Less than or equal to' => '<=', 
    'Not equal' => '<>'
  }
  TIME_PERIODS  = ['Second', 'Minute', 'Hour', 'Day', 'Week'].freeze
end
