require %{#{RAILS_ROOT}/app/controllers/application}

class GoogleSiteMap

  cattr_accessor :url_base

  @@url_base = "http://www.example.com"
  
  #initilize the object by passing the path to the controllers directory
  def initialize(base_dir)
    @base_dir = base_dir
  end

  #builds the url list according to the options passed.
  # options[:lastmod]==:mtime will set the lastmod of the url to the last modification time of the controller
  def url_list(options={})
    @options = options
    url_list_for_dir(@base_dir)
  end
  private
  
  def url_list_for_dir(dir)
    #puts "generating in #{dir.join("/")}"
    #puts "-----------------------------"
    Dir.foreach(dir.join("/")) do |f|
      next if [".",".."].include? f
      if File.directory?("#{dir}/#{f}")
        url_list_for_dir([dir,f].flatten)
        next
      end
      next if not(f=~/\.rb$/) or f=="application.rb"
      f= f.sub("\.rb","")
      require "#{dir.join("/")}/#{f}"
      class_name = dir[1..dir.length].collect{|d| d.classify}.join("::")+"::"+f.classify
      klass = eval(class_name)
      if not(klass.is_a?(::Class))
        raise "Class #{class_name} not found"
      end
      klass.instance_methods(false).each do |m|
        puts @@url_base+(dir.length>1 ? "/":"")+(dir[1..dir.length].join("/"))+"/"+f.gsub("_controller","")+"/"+m \
        + lastmod(File.new("#{dir.join("/")}/#{f}.rb"))
        
      end
    end
  end

  #returns the lastmod string for the url according to otpions[:lastmod]
  def lastmod(file)
      if @options[:lastmod]==:mtime
        return " lastmod="+DateTime.parse(file.mtime.rfc2822).to_s
      else
        return ""
      end
  end
end



GoogleSiteMap.url_base = "http://www.myowndb.com"
gsm = GoogleSiteMap.new( [%{#{RAILS_ROOT}/app/controllers}])

# next line includes lastmod infrmation based on last modification time of the controller file
gsm.url_list( :lastmod => :mtime)
#uncomment following line to remove the lastmod element
#gsm.url_list
