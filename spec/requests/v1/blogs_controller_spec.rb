require 'rails_helper'

describe 'Blogs API', type: :request do
  describe 'GET #index' do
    it 'populates an array of blogs' do
      3.times { FactoryGirl.create(:blog) }
      get '/v1/blogs', nil, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      json = JSON.parse(response.body)
      expect(json.length).to eq(3)
    end

    it 'responds with HTTP success' do
      get '/v1/blogs', nil, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    before :each do
      @blog = FactoryGirl.create(:blog)
    end

    it 'assigns a blog based on id' do
      get "/v1/blogs/#{@blog.id}", nil, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      json = JSON.parse(response.body)
      expect(json['title']).to eq(@blog.title)
      expect(json['content']).to eq(@blog.content)
    end

    it 'responds with HTTP success' do
      get "/v1/blogs/#{@blog.id}", nil, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before :each do
      @entry_params = {
        blog: {
          title: 'Some Elegant Title',
          content: 'Such elegant content...wow.'
        }
      }
    end

    it 'should create a new blog from the blog parameters' do
      post '/v1/blogs', @entry_params, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      json = JSON.parse(response.body)
      expect(json['title']).to eq(@entry_params[:blog][:title])
      expect(json['content']).to eq(@entry_params[:blog][:content])
    end

    it 'responds with HTTP success when blog is saved' do
      post '/v1/blogs', @entry_params, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    before :each do
      @blog = FactoryGirl.create(:blog)
    end

    it 'assigns a blog based on id' do
      get "/v1/blogs/#{@blog.id}", nil, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      json = JSON.parse(response.body)
      expect(json['title']).to eq(@blog.title)
      expect(json['content']).to eq(@blog.content)
    end

    it 'responds with HTTP success' do
      get "/v1/blogs/#{@blog.id}", nil, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    before :each do
      @blog = FactoryGirl.create(:blog)
      @entry_params = {
        blog: {
          id: @blog.id,
          title: @blog.title,
          content: 'some new content blah blah whatever',
        }
      }
    end

    it 'updates a blog with entered parameters' do
      patch "/v1/blogs/#{@blog.id}", @entry_params, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@blog.id)
      expect(json['title']).to eq(@blog.title)
      expect(json['content']).to eq(@entry_params[:blog][:content])
    end

    it 'responds with HTTP success' do
      patch "/v1/blogs/#{@blog.id}", @entry_params, { 'HTTP_ACCEPT' => 'application/vnd.blogs.v1' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @blog = FactoryGirl.create(:blog)
    end

    it 'deletes the selected blog' do
      expect {
        delete "/v1/blogs/#{@blog.id}", nil, { 'HTTP_ACCEPT' => 'application/vnd.blog.v1' }
      }.to change(Blog, :count).by(-1)
    end

    it 'responds with HTTP success' do
      delete "/v1/blogs/#{@blog.id}", nil, { 'HTTP_ACCEPT' => 'application/vnd.blog.v1' }
      expect(response).to have_http_status(:success)
    end
  end
end
