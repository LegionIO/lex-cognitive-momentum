# frozen_string_literal: true

require_relative 'cognitive_momentum/version'
require_relative 'cognitive_momentum/helpers/constants'
require_relative 'cognitive_momentum/helpers/idea'
require_relative 'cognitive_momentum/helpers/momentum_engine'
require_relative 'cognitive_momentum/runners/cognitive_momentum'
require_relative 'cognitive_momentum/helpers/client'

module Legion
  module Extensions
    module CognitiveMomentum
      extend Legion::Extensions::Core if Legion::Extensions.const_defined?(:Core)
    end
  end
end
