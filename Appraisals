%w(2.1.0 2.2.0 2.3.0 2.4.0 2.5.0 2.6.0 2.7.0 2.8.0).each do |json_schema_version|
  %w(4.0 4.1 4.2 5.0 5.1).each do |active_support_version|
    appraise "version-#{json_schema_version}-#{active_support_version}" do
      gem "json-schema", "~> #{json_schema_version}"
      gem "activesupport", "~> #{active_support_version}"
    end
  end
end
