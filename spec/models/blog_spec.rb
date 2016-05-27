require 'rails_helper'

RSpec.describe Blog, :type => :model do
  it 'is valid with a title and with content' do
    blog = Blog.new(title: 'Some title', content: 'Much adou about some content or other.')
    expect(blog.valid?).to eq(true)

  end

  it 'is invalid without a title' do
    blog = Blog.new(title: nil, content: 'Much adou about some content or other.')
    blog.valid?
    expect(blog.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without content' do
    blog = Blog.new(title: 'Some title', content: nil)
    blog.valid?
    expect(blog.errors[:content]).to include("can't be blank")
  end

  it 'is valid only with a unique title' do
    FactoryGirl.create(:blog, title: 'Unique Super-Original Title')
    blog = Blog.new(title: 'Unique Super-Original Title', content: 'Much adou about being a hipster.')
    blog.valid?
    expect(blog.errors[:title]).to include("has already been taken")
  end
end
