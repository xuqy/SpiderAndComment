class TaskController < ApplicationController
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
      urls_found = {seed_url}
      while !queue.empty and download_count < number do
        url = queue.shift
        // download 'url'
        page = Page.new :url => url, :html => '', :size = ''
        task.pages << page
        urls_found_in_this_page = ()
        for url_found in urls_found_in_this_page do 
          next if urls_found{url_found}
          urls_found{url_found} = 1
          queue << url_found
        end
      end
    end
  end
end
