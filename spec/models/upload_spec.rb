require 'spec_helper'






describe Upload do
  before(:each) do
    @valid_attributes = {:name => "untitled.txt", :content => "there is content"}  
    @invalid_attributes = {:name => "111111", :content => ""}
    @real_attributes = {:name => "spec/fixtures/rspec.txt", :content => ""}
  end
  def mock_uploader(file, type = ' 	text/plain')
    filename = "%s/%s" % [ File.dirname(__FILE__), file ]
    uploader = ActionController::UploadedStringIO.new
    uploader.original_path = filename
    uploader.content_type = type
    def uploader.read
      File.read(original_path)
    end
    def uploader.size
      File.stat(original_path).size
    end
    uploader
  end
  
  
  it "should create a new instance given valid attributes" do
    Upload.create!(@valid_attributes)
  end
  
  it "should create a record containing the filename and some content" do
    @upload = Upload.create!(@real_attributes)
    id = @upload.id
    created = Upload.find_by_id(id)
    created.name.should == @real_attributes[:name]
    created.content.should == @real_attributes[:content]
  end
  
  it "should create a record containing the filename and content of a real text file" do
    File.readable?(@real_attributes[:name]).should == true
    uploader = mock_uploader @real_attributes[:name]
    uploader.original_path.should == @real_attributes[:name]
    #@upload = Upload.create(@real_attributes)
  end
  
  
  it "should not place a file on the filesystem" do
    pending
  end
  
  it "should only create a record if content is available" do
    pending
  end
  
  it "should be a text file" do
    pending
  end
end
