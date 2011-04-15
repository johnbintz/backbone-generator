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
      system %{bin/backbone-generator view Section::Model}

      File.file?(view = 'public/javascripts/views/section/model_view.js').should be_true
      File.file?(spec = 'spec/javascripts/views/section/model_view_spec.js').should be_true
      File.file?(template = 'app/views/section/model.jst').should be_true

      File.read(view).should match(/SectionModel/)
      File.read(view).should match(%r{template: JST\['section/model'\]})
      File.read(spec).should match(/SectionModel/)
    end
  end

  describe 'collection view' do
    it "should generate the collection view files" do
      system %{bin/backbone-generator collection-view Section::Model}

      File.file?(view = 'public/javascripts/views/section/models_view.js').should be_true
      File.file?(spec = 'spec/javascripts/views/section/models_view_spec.js').should be_true
      File.file?(template = 'app/views/section/models.jst').should be_true

      File.read(view).should match(/SectionModelsView/)
      File.read(view).should match(%r{template: JST\['section/models'\]})
      File.read(spec).should match(/SectionModelsView/)
    end
  end

  describe 'collection' do
    it "should generate the collection files" do
      system %{bin/backbone-generator collection Section::Model}

      File.file?(collection = 'public/javascripts/collections/section/models_collection.js').should be_true
      File.file?(spec = 'spec/javascripts/collections/section/models_collection_spec.js').should be_true

      File.read(collection).should match(/SectionModelsCollection/)
      File.read(collection).should match(%r{section/model})
      File.read(spec).should match(/SectionModelsCollection/)
    end
  end
end
