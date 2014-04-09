require 'spec_helper'
require 'capybara/rspec'
require './app'

Capybara.app = App
Capybara.app_host = 'http://localhost:9292'

feature 'url shortener app' do
  DB[:urls].delete

  scenario 'user can submit a link, see the new shortened url, and is redirected to the original url if they click on it' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'http://gschool.it'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'http://gschool.it'
    id = "#{current_path.gsub('/', '')}"
    visit "http://localhost:9292/#{id}"
    expect(current_url).to eq 'http://gschool.it/'
  end

  scenario 'user can shorten a url using vanity' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'www.google.com'
    fill_in 'vanity', :with => 'goo'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content '/goo'
    visit 'http://localhost:9292/goo'
    expect(current_url).to eq 'http://www.google.com/'
  end

  scenario 'user can return to the homepage to shorten another link' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'gschool.it'
    within 'form' do
      click_button 'Shorten'
    end
    click_link '"Shorten" another URL'
    expect(page).to have_title 'URL Shortener'
  end

  scenario 'user sees an error message on the homepage if they enter an invalid url' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'gschool'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'The text you entered is not a valid URL.'
  end

  scenario 'user sees and error message on the homepage if they leave the input field blank' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => ''
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'The URL cannot be blank'
  end

  scenario 'user sees and error message if a vanity already exists' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'google.com'
    fill_in 'vanity', :with => 'foo'
    within 'form' do
      click_button 'Shorten'
    end

    click_link '"Shorten" another URL'
    fill_in 'Enter URL to shorten', :with => 'gschool.it'
    fill_in 'vanity', :with => 'foo'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'That vanity is already taken'
  end

  scenario 'user will see an error when vanity url contains profainity' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'google.com'
    fill_in 'vanity', :with => 'fuck'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'No Profanity Please.'
  end

  scenario 'user will see an error when vanity url is over 12 characters' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'google.com'
    fill_in 'vanity', :with => 'thisisreallylong'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'Vanity URLs must be under 13 characters'
  end

  scenario 'user will see an error when vanity url contains numbers' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'google.com'
    fill_in 'vanity', :with => 'weee33'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'Letters Only'
  end

  scenario 'user will not see an error message when they refresh the page' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => ''
    within 'form' do
      click_button 'Shorten'
      visit '/'
      expect(page).to_not have_content 'The URL cannot be blank'
    end
  end

  scenario 'user will see the number of times the shortened URL has been clicked on the stats page' do
    visit '/'
    fill_in 'Enter URL to shorten', :with => 'google.com'
    within 'form' do
      click_button 'Shorten'
    end
    expect(page).to have_content 'Visits: 0'

    id = "#{current_path.gsub('/', '')}"
    5.times do
      visit "/#{id}"
    end
    5.times do
      visit "/#{id}?stats=true"
    end
    expect(page).to have_content 'Visits: 5'
  end
end
