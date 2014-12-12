require 'spec_helper'

RSpec::Matchers.define :define_attribute do |attribute|
  match do |entity_klass|
    entity = entity_klass.new 'entity'
    entity.respond_to?(attribute) &&
    entity.respond_to?("#{ attribute }=")
  end

  failure_message do |entity_klass|
    "#{ entity_klass.class } does not define attribute #{ attribute.inspect }"
  end

  failure_message_when_negated do |entity_klass|
    "#{ entity_klass.class } does define attribute #{ attribute.inspect }"
  end
end
