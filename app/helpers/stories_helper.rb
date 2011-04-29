module StoriesHelper
  
  def sort_tabs
    controller_name = :stories    
    tabs = { 
      :new => {:path => stories_sorted_by_new_path, :action_name => :newest, :active_title => "what's new"},
      :top => {:path => stories_sorted_by_top_path, :action_name => :top, :active_title => "top scoring"}
    }
    tabs.map do |name, link|
      content_tag :li do
        if active_tab = (action_name == link[:action_name].to_s)
          link_to link[:active_title], link[:path], :class => :active
        else
          link_to name, link[:path]
        end
      end
    end.join
  end
  
end
