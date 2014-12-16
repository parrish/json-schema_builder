# JSON::SchemaBuilder

[![Build Status](https://travis-ci.org/parrish/json-schema_builder.svg)](https://travis-ci.org/parrish/json-schema_builder)
[![Code Climate](https://codeclimate.com/github/parrish/json-schema_builder/badges/gpa.svg)](https://codeclimate.com/github/parrish/json-schema_builder)
[![Test Coverage](https://codeclimate.com/github/parrish/json-schema_builder/badges/coverage.svg)](https://codeclimate.com/github/parrish/json-schema_builder)
[![Gem Version](https://badge.fury.io/rb/json-schema_builder.svg)](http://badge.fury.io/rb/json-schema_builder)

##### Build [JSON Schemas](http://json-schema.org) with Ruby. Validates JSON using [json-schema](https://github.com/ruby-json-schema/json-schema)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json-schema_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json-schema_builder

## Usage

### Building schemas

```ruby
require 'json/schema_builder'

class YourSchema
  include JSON::SchemaBuilder

  def schema
    object do
      string :name, min_length: 1, required: true
      array :your_ids do
        max_items 10
        unique_items true
        items type: :integer
      end
    end
  end
end

builder = YourSchema.new
```

`builder.schema.as_json` will return a valid JSON schema:

```json
{
  "type": "object",
  "required": "name",
  "properties": {
    "name": {
      "type": "string",
      "minLength": 1
    },
    "your_ids": {
      "type": "array",
      "maxItems": 10,
      "uniqueItems": true,
      "items": { "type": "integer" }
    }
  }
}
```

[More examples](https://github.com/parrish/json-schema_builder/tree/master/spec/support/examples) can be found in the specs.

### Validating data against a schema

`builder.schema.validate(data)` will validate your object against the schema:
```ruby
builder.schema.validate({ }) # => false
builder.schema.validate name: 'Your Name' # => true
```

`builder.schema.validate!(data)` validates your object, raising an exception on failure:
```ruby
builder.schema.validate!({ })
# JSON::Schema::ValidationError: The property '#/' did not contain a required property of 'name'

builder.schema.validate! name: 'Your Name', your_ids: [1, 1, 2]
# JSON::Schema::ValidationError: The property '#/your_ids' contained duplicated array values
```

`builder.schema.fully_validate(data)` validates the object and reports all invalid properties:
```ruby
builder.schema.fully_validate your_ids: 'fail'
# [
#   "The property '#/your_ids' of type String did not match the following type: array ",
#   "The property '#/' did not contain a required property of 'name'"
# ]
```

Fragment validation can be accomplished by specifying the schema fragment:
```ruby
builder.schema.validate [1], fragment: '#/properties/your_ids' # => true
```

### Configuring

[json-schema](https://github.com/ruby-json-schema/json-schema) validation options can be specified in several contexts:

```ruby
# As a global default
JSON::SchemaBuilder.configure do |opts|
  opts.validate_schema = true
end

# As a class-level default
YourSchema.configure do |opts|
  opts.insert_defaults = true
end

# Or at validation
builder.schema.validate data, strict: true, validate_schema: false

# Results in
{
  validate_schema: false,
  insert_defaults: true,
  strict: true
}
```

## Contributing

1. Fork it ( https://github.com/parrish/json-schema_builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
