# Define attributes for <%= class_name %>:
KathyLee.attributes(:<%= singular_name %>) do
<% for attribute in attributes -%>
  <%= attribute.name %> <%= attribute.default.inspect %>
<% end -%>
end

KathyLee.define(:<%= singular_name %>) do
  <%= singular_name %> = <%= class_name %>.new(options)
  <%= singular_name %>
end