# workflow for creating an API endpoint:
# 1. write my request test - happy path (assuming all goes well)
# - things to test: 1. correct status code; 2. correct JSON; sometimes 3. correct headers
# 2. run it & watch it fail
# - `rspec` for whole test suite, or `rspec spec/requests/songs_requests_spec.rb:16`
# 3. progressively fix errors, writing code to get past each one
# 4. at some point, we'll find we might need to create a model. At that point, we write model tests (`spec/models/my_model_spec.rb`) & get them passing
#  - model tests include: tests for associations, validations, & class & instance methods (public).
# 5. come back to our request test and keep coding to make it pass.
# 6. add tests for error cases (user unauthenticated, didn't provide required info when creating a song)

require 'rails_helper'

describe 'Outfits endpoints' do
  describe 'GET/outfits' do
    it 'returns JSON for outfits' do
      # create a few songs using Factory Girl
      outfits = create_list(:outfit, 3)

      # make a request to GET/songs
      get(
        outfits_url,
        {},
        { 'Accept' => 'application/vnd.comfy-weather-server.com; version=1', 'Content-Type' => 'application/json'}
      )
      
      # check the responses
      expect(response).to have_http_status :ok
      expect(response.body).to have_json_size(3).at_path('outfits')
    end
  end
end
