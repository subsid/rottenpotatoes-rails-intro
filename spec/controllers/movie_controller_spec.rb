require 'rails_helper'

describe MoviesController do
  describe 'Search movies by the same director' do
    it 'should call Movie.movies_by_director' do
      expect(Movie).to receive(:movies_by_director).with('Aladdin')
      get :movies_by_director, { title: 'Aladdin' }
    end

    it 'should assign movies by director if director exists' do
      movies = ['M1', 'M2']
      Movie.stub(:movies_by_director).with('M1').and_return(movies)
      get :movies_by_director, { title: 'M1' }
      expect(assigns(:movies_by_director)).to eql(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:movies_by_director).with('M1').and_return(nil)
      get :movies_by_director, { title: 'M1' }
      expect(response).to redirect_to(root_url)
    end
  end
end

