require 'spec_helper'

RSpec.shared_examples_for 'a container entity' do
  subject{ described_class.new 'name' }
  it{ is_expected.to respond_to :children }
  it{ is_expected.to respond_to :children= }
  its(:children){ is_expected.to eql [] }
end
