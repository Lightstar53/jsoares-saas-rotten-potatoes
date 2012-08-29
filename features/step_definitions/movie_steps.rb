require 'uri'
require 'cgi'

def path_to(page_name)
  case page_name
  when /Create New Movie/i then new_movie_path
  when /Search Results/i then '/movies/search_tmdb'
  when /"Men In Black" Movie/i then '/movies/1'
  when /RottenPotatoes home/i then movies_path
  end
end

Given /^I am on the (.*?) page$/ do |page_name|
  visit path_to page_name
end

When /^I follow "(.*?)"$/ do |link|
  click_link(link)
end

Then /^I should be on the (.*?) page$/ do |arg1|
  expected_path = path_to(arg1)
  current_path = URI.parse(current_url).path
  current_path.should == expected_path
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I select "(.*?)" from "(.*?)"$/ do |value, field|
  select(value, :from => field)
end

When /^I press "(.*?)"$/ do |button_name|
  click_button(button_name)
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content text
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  page.should_not have_content text
end
