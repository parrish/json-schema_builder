require 'spec_helper'

RSpec.describe Examples::ObjectOrArray, type: :integration do
  it_behaves_like 'a builder' do
		let(:expected_json) do
			{
				anyOf: [{
          type: :object,
					additionalProperties: false,
					properties: {
						thing: { type: :any },
						other: {
							anyOf: [{
								type: :object,
								additionalProperties: false,
								properties: {
									stuff: { type: :string }
								}
							}, {
								type: :array,
								items: {
                  type: :object,
									additionalProperties: false,
									properties: {
										stuff: { type: :string }
									}
								}
							}]
						}
					}
				}, {
					type: :array,
					items: {
						type: :object,
						additionalProperties: false,
						properties: {
							thing: { type: :any },
							other: {
								anyOf: [{
									type: :object,
									additionalProperties: false,
									properties: {
										stuff: {
											type: :string
										}
									},
								},
								{
									type: :array,
									items: {
										type: :object,
										additionalProperties: false,
										properties: {
											stuff: {
                        type: :string
											}
										}
									}
								}]
							}
						}
					}
				}, {
					type: :null
				}]
			}
		end
	end
end
