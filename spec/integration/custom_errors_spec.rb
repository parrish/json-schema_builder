require 'spec_helper'

RSpec.describe Examples::CustomErrors, type: :integration do
  let(:klass) { described_class.new({}) }

  it "customizes with a proc" do
    errors = schema.fully_validate({ user: "123", settings: { name: 456 } }, customize_errors: true)
    expect(errors).to include hash_including(message: "Custom object error")
  end

  it "customizes with a string" do
    errors = schema.fully_validate({ settings: { name: 456 } }, customize_errors: true)
    expect(errors).to include hash_including(message: "Custom name error")
  end

  it "customizes required errors" do
    errors = schema.fully_validate({ settings: { } }, customize_errors: true)
    expect(errors).to include hash_including(message: %q(#/ requires properties ["user"]))
    expect(errors).to include hash_including(message: %q(#/settings requires properties ["name"]))
  end

  it "merges error handlers" do
    schema = klass.example.schema.merge(klass.example2.schema)
    errors = schema.fully_validate({ settings: { other: 123 } }, customize_errors: true)
    expect(errors).to include hash_including(message: "Other error")
    expect(errors).to include hash_including(message: %q(#/ requires properties ["user"]))
    expect(errors).to include hash_including(message: %q(#/settings requires properties ["name", "other"]))
  end

  it "flattens nested errors" do
    schema = klass.any_of
    errors = schema.fully_validate({ user: { settings: { name: 123 } }}, customize_errors: true)
    expect(errors.length).to eq(3)
    expect(errors).to include hash_including(message: "Nested")
  end
end
