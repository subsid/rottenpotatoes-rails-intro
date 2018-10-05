Given /^the following movies exist:$/ do |table|
  table.hashes.each do |params|
    Movie.create params
  end
end

Then /^the director of "(.+)" should be "(.+)"/ do |title, director|
  movie = Movie.find_by(title: title)
  visit movie_path(movie)
  expect(page.body).to match(/Director:\s#{director}/)
end

