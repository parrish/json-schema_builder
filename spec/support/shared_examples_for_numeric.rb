require 'spec_helper'

RSpec.shared_examples_for 'a numeric entity' do
  subject{ described_class }
  it{ is_expected.to define_attribute :multiple_of }
  it{ is_expected.to define_attribute :minimum }
  it{ is_expected.to define_attribute :maximum }
  it{ is_expected.to define_attribute :exclusive_minimum }
  it{ is_expected.to define_attribute :exclusive_maximum }
end
