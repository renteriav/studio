<% if @teacher.errors.any? %>
  <div id="error_explanation">
    <h2><%= pluralize(@teacher.errors.count, "error") %> prohibited this teacher from being saved:</h2>

    <ul>
    <% @teacher.errors.full_messages.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
    </ul>
  </div>
<% end %>