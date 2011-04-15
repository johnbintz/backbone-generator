require 'spec_helper'
require 'fileutils'

describe 'backbone-generator' do
  def clean!
    FileUtils.rm_rf 'public'
    FileUtils.rm_rf 'spec/javascripts'
    FileUtils.rm_rf 'app'
  end

  before { clean! }
  after { clean! }

  describe 'model' do
    it "should generate the model files" do
      system %{bin/backbone-generator model Section::Model}

      File.file?(model = 'public/javascripts/models/section/model.js').should be_true
      File.file?(spec = 'spec/javascripts/models/section/model_spec.js').should be_true

      File.read(model).should match(/SectionModel/)
      File.read(spec).should match(/SectionModel/)
    end
  end

  describe 'view' do
    it "should generate the view files" do
      system %{bin/backbone-generator view Section::View}

      File.file?(view = 'public/javascripts/views/section/view.js').should be_true
      File.file?(spec = 'spec/javascripts/views/section/view_spec.js').should be_true
      File.file?(template = 'app/views/section/view.jst').should be_true

      File.read(view).should match(/SectionView/)
      File.read(view).should match(%r{template: JST\['section/view'\]})
      File.read(spec).should match(/SectionView/)
    end
  end

  describe 'collection' do
    it "should generate the collection files" do
      system %{bin/backbone-generator collection Section::Collection}

      File.file?(collection = 'public/javascripts/collections/section/collection.js').should be_true
      File.file?(spec = 'spec/javascripts/collections/section/collection_spec.js').should be_true

      File.read(collection).should match(/SectionCollection/)
      File.read(collection).should match(%r{section/collection})
      File.read(spec).should match(/SectionCollection/)
    end
  end
end
