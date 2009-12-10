require 'uri'
require 'open-uri'

class TaskController < ApplicationController
  @@valid_suffixes = {:html => 1, :htm => 1}
  def create
    @task = Task.new
  end

  def list
    @tasks = Task.find :all
  end

  def save
    @task.save!
  rescue Exception => err
    logger.error err
    flash[:notice] = "e.message"
    redirect_to :action => 'create'
  end

  def launch
    task = Task.find(params[:id])
    seed_url = task.seed_url
    number = task.number
    charset = task.charset
    queue = [seed_url]
    Thread.new do
      download_count = 0
      urls_found = [seed_url]
      while !queue.empty and download_count < number do
        url = queue.shift
        begin
          html = open(url).read
        rescue
          next
        end
        page = Page.new :url => url, :html => html, :size => html.size
        task.pages << page
        uris_found_in_this_page = URI.extract(html)
        for new_uri in uris_found_in_this_page do 
          next if urls_found[new_uri]
          next unless new_uri =~ /^http:/
          if new_uri =~ /\.([^.\/]+)$/ 
            next unless @@valid_suffixes[$1.downcase]
          end
          queue << new_uri
          urls_found[new_uri] = 1
        end
      end
    end
  end
end
