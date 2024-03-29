# Copyright (c) 2007 Thiago Jackiw
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# The "Created with Sitealizer" footer text should not be removed from the 
# locations where it's currently shown (under the '/sitealizer' controller)
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'sitealizer'
::SitealizerController.view_paths = [File.join(directory, 'lib/app/views')]
unless SiteTracker.table_exists?
  ActiveRecord::Schema.create_table(SiteTracker.table_name) do |t|
    t.column :path,           :string
    t.column :ip,             :string
    t.column :referer,        :string
    t.column :language,       :string
    t.column :user_agent,     :string
    t.column :created_at,     :datetime
    t.column :created_on,     :date
  end

end