require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "span", count: 10
  end

  test "Filling in /new with random word yeilds a response that the word is not in the grid" do
    visit new_url
    fill_in "answer", with: "hello"
    click_on "Play"

    has_text? "Sorry, but HELLO can't be built out of"
  end

  test "Filling in /new with a one-letter consonant word yeilds a response that the word is not valid English word" do
    visit new_url
    fill_in "answer", with: "H"
    click_on "Play"

    has_text? "Sorry, but H does not seem to be a valid English word..."
  end
end
