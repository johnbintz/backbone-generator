require 'spec_helper'
require 'fileutils'

describe 'backbone-generator' do
  def clean!
    FileUtils.rm_rf 'public'
    FileUtils.rm_rf 'spec/javascripts'
    FileUtils.rm_rf 'app'
  end

  def run(*opts)
    system %{bin/backbone-generator #{opts.join(' ')}}
  end

  before { clean! }
  after { clean! }

  describe 'coffeescript' do
    def should_generate_model
      File.file?(model = 'app/assets/javascripts/models/section/model.coffee').should be_true
      File.file?(spec = 'spec/javascripts/models/section/model_spec.coffee').should be_true

      File.read(model).should match(/SectionModel/)
      File.read(spec).should match(/SectionModel/)
    end

    def should_generate_view
      File.file?(view = 'app/assets/javascripts/views/section/model_view.coffee').should be_true
      File.file?(spec = 'spec/javascripts/views/section/model_view_spec.coffee').should be_true
      File.file?(template = 'app/views/section/models/view.jst').should be_true

      File.read(view).should match(/SectionModel/)
      File.read(view).should match(%r{template: JST\['section/models/view'\]})
      File.read(spec).should match(/SectionModel/)
    end

    def should_generate_collection
      File.file?(collection = 'app/assets/javascripts/collections/section/models.coffee').should be_true
      File.file?(spec = 'spec/javascripts/collections/section/models_spec.coffee').should be_true

      File.read(collection).should match(/SectionModels/)
      File.read(collection).should_not match(/SectionModelss/)
      File.read(collection).should match(%r{section/model})
      File.read(spec).should match(/SectionModels/)
      File.read(spec).should_not match(/SectionModelss/)
    end

    def should_generate_collection_view
      File.file?(view = 'app/assets/javascripts/views/section/models_view.coffee').should be_true
      File.file?(spec = 'spec/javascripts/views/section/models_view_spec.coffee').should be_true
      File.file?(template = 'app/views/section/models/list.jst').should be_true

      File.read(view).should match(/SectionModelsView/)
      File.read(view).should_not match(/SectionModelssView/)
      File.read(view).should match(/SectionModelView/)
      File.read(view).should match(%r{template: JST\['section/models/list'\]})
      File.read(spec).should match(/SectionModelsView/)
      File.read(spec).should_not match(/SectionModelssView/)
    end

    describe 'model' do
      it "should generate the model files" do
        run "model", "Section::Model", '--coffee'

        should_generate_model
      end
    end

    describe 'view' do
      it "should generate the model files" do
        run "view", "Section::Model", '--coffee'

        should_generate_view
      end
    end

    describe 'collection view' do
      it "should generate the collection view files" do
        run "collection-view", "Section::Model", '--coffee'

        should_generate_collection_view
      end
    end

    describe 'collection' do
      it "should generate the collection files" do
        run "collection", "Section::Model", '--coffee'

        should_generate_collection
      end
    end

    describe 'scaffold' do
      it "should generate everything!" do
        run "scaffold", "Section::Model", '--coffee'

        should_generate_model
        should_generate_view
        should_generate_collection
        should_generate_collection_view
      end
    end

    describe 'spec helper' do
      it "should generate a spec helper" do
        run "spec-helper", '--coffee'

        File.file?(collection = 'spec/javascripts/helpers/backbone_spec_helper.coffee').should be_true
      end
    end

    describe 'app helper' do
      it "should generate an app helper" do
        run "app-helper", '--coffee'

        File.file?(collection = 'app/assets/javascripts/application/backbone_helper.coffee').should be_true
      end
    end

    describe 'application scaffold' do
      it "should generate an application scaffold" do
        run "app-scaffold", '--coffee'

        File.file?(app = 'app/assets/javascripts/application/app_view.coffee').should be_true
        File.file?(app_view = 'app/views/application/app_view.jst').should be_true
        File.file?(controller = 'app/assets/javascripts/application/controller.coffee').should be_true
        File.file?(spec = 'spec/javascripts/application/app_view_spec.coffee').should be_true
      end
    end
  end

  describe 'javascript' do
    def should_generate_model
      File.file?(model = 'public/javascripts/models/section/model.js').should be_true
      File.file?(spec = 'spec/javascripts/models/section/model_spec.js').should be_true

      File.read(model).should match(/SectionModel/)
      File.read(spec).should match(/SectionModel/)
    end

    def should_generate_view
      File.file?(view = 'public/javascripts/views/section/model_view.js').should be_true
      File.file?(spec = 'spec/javascripts/views/section/model_view_spec.js').should be_true
      File.file?(template = 'app/views/section/models/view.jst').should be_true

      File.read(view).should match(/SectionModel/)
      File.read(view).should match(/return this/)
      File.read(view).should match(%r{template: JST\['section/models/view'\]})
      File.read(spec).should match(/SectionModel/)
    end

    def should_generate_collection
      File.file?(collection = 'public/javascripts/collections/section/models.js').should be_true
      File.file?(spec = 'spec/javascripts/collections/section/models_spec.js').should be_true

      File.read(collection).should match(/SectionModels/)
      File.read(collection).should_not match(/SectionModelss/)
      File.read(collection).should match(%r{section/model})
      File.read(spec).should match(/SectionModels/)
      File.read(spec).should_not match(/SectionModelss/)
    end

    def should_generate_collection_view
      File.file?(view = 'public/javascripts/views/section/models_view.js').should be_true
      File.file?(spec = 'spec/javascripts/views/section/models_view_spec.js').should be_true
      File.file?(template = 'app/views/section/models/list.jst').should be_true

      File.read(view).should match(/SectionModelsView/)
      File.read(view).should_not match(/SectionModelssView/)
      File.read(view).should match(/SectionModelView/)
      File.read(view).should match(/return this/)
      File.read(view).should match(%r{template: JST\['section/models/list'\]})
      File.read(spec).should match(/SectionModelsView/)
      File.read(spec).should_not match(/SectionModelssView/)
    end

    describe 'model' do
      it "should generate the model files" do
        run "model", "Section::Model"

        should_generate_model
      end
    end

    describe 'view' do
      it "should generate the view files" do
        run "view", "Section::Model"

        should_generate_view
      end
    end

    describe 'collection view' do
      context 'without trailing s' do
        it "should generate the collection view files" do
          run "collection-view", "Section::Model"

          should_generate_collection_view
        end
      end

      context 'with trailing s' do
        it "should generate the collection view files" do
          run "collection-view", "Section::Models"

          should_generate_collection_view
        end
      end
    end

    describe 'collection' do
      context 'without trailing s' do
        it "should generate the collection files" do
          run "collection", "Section::Model"

          should_generate_collection
        end
      end

      context 'with trailing s' do
        it "should generate the collection files" do
          run "collection", "Section::Models"

          should_generate_collection
        end
      end
    end

    describe 'scaffold' do
      it "should generate everything!" do
        run "scaffold", "Section::Model"

        should_generate_model
        should_generate_view
        should_generate_collection
        should_generate_collection_view
      end
    end

    describe 'spec helper' do
      it "should generate a spec helper" do
        run "spec-helper"

        File.file?(collection = 'spec/javascripts/helpers/backbone_spec_helper.js').should be_true
      end
    end

    describe 'app helper' do
      it "should generate an app helper" do
        run "app-helper"

        File.file?(collection = 'public/javascripts/application/backbone_helper.js').should be_true
      end
    end

    describe 'application scaffold' do
      it "should generate an application scaffold" do
        run "app-scaffold"

        File.file?(app = 'public/javascripts/application/app_view.js').should be_true
        File.file?(app_view = 'app/views/application/app_view.jst').should be_true
        File.file?(controller = 'public/javascripts/application/controller.js').should be_true
        File.file?(spec = 'spec/javascripts/application/app_view_spec.js').should be_true
      end
    end
  end
end
