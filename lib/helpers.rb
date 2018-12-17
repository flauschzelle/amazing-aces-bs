include Nanoc::Helpers::Rendering
include Nanoc::Helpers::ChildParent

def events
    blk = -> { newest_first(@items.find_all("/**/*").select{|i| i[:eventdate] && i[:eventdate].jd >= Date::today.jd}.sort_by{|i| i[:eventdate].jd}) }
    if @items.frozen?
        @events ||= blk.call
    else
        blk.call
    end
end

def gallerythings
    blk = -> { newest_first(@items.find_all("/**/*").select{|i| i[:gallery]}) }
    if @items.frozen?
        @gallerythings ||= blk.call
    else
        blk.call
    end
end

def newsthings
    blk = -> { newest_first(@items.find_all("/**/*").select{|i| i[:news]}) }
    if @items.frozen?
        @newsthings ||= blk.call
    else
        blk.call
    end
end

def newestthings
    blk = -> { newest_first(@items.find_all("/**/*").select{|i| i[:news]}).take(3) }
    if @items.frozen?
        @newestthings ||= blk.call
    else
        blk.call
    end
end

def things
    blk = -> { newest_first(@items.find_all("/**/*").select{|i| i[:published]}) }
    if @items.frozen?
        @things ||= blk.call
    else
        blk.call
    end
end

def link_to item, text=nil
    text = item[:title] if text.nil?
    "<a href=\"#{link_for(item)}\">#{text}</a>"
end

def calculate_tags
    @items.select{|i| i[:tags]}.map{|i| i[:tags]}.flatten.uniq.sort
end

def tags
    calculate_tags
end
    
#datastructure for categories of gallery items
def gallery_items_for tag
    gallerythings.select do |item|
        item[:tags] and item[:tags].include? tag
    end
end
    
#look up in which gallery categories this item is, and at which place
#only use this in gallery pages!
def gallery_categories_for item
    item[:tags].map do |tag|
        [tag, gallery_items_for(tag).size, gallery_items_for(tag).index(item)]
    end
end

#gives the next gallery item in the specified category
def gallery_next_for item, tag
    gallery_next_nr = gallery_items_for(tag).index(item)+1
    if gallery_next_nr == gallery_items_for(tag).size
        gallery_next_nr = 0
    end
    gallery_items_for(tag)[gallery_next_nr]
end

#gives the previous gallery item in the specified category
def gallery_prev_for item, tag
    gallery_prev_nr = gallery_items_for(tag).index(item)-1
    if gallery_prev_nr == -1
        gallery_prev_nr = gallery_items_for(tag).size-1
    end
    gallery_items_for(tag)[gallery_prev_nr]
end

def menutext_for item
    menutext_breaking = if item[:menu]
        item[:menu]
    else
        item[:title]
    end
	menutext_breaking.gsub(" ", "&nbsp;").gsub("-", "&#x2011;")
end

def link_for item
    if item[:url]
        item[:url]
    else
        item.path
    end
end

def tags_for item, link=true
    item[:tags].map do |tag|
        if link
            "<a href=\"/news/##{tag}\">#{tag}</a>"
        else
            tag
        end
    end.join(", ")
end

def lang_for item
    if item[:tags] and item[:tags].include? "en"
        "en"
    else
        "de"
    end
end

def abstract_for item
    if item[:subtitle]
        item[:subtitle]
    else
        content = item.raw_content.dup
        content.gsub!(/!\[([^\]]*)\]\([^)]*\)/,"") # remove images
        content.gsub!(/\[([^\]]*)\]\([^)]*\)/,"\\1") # replace links with link text
        content.gsub!(/[*"]/,"") # remove italic and bold markers and quotations
        content.strip!
        abstract = content[/^[[:print:]]{20,256}[.…!?:*]/] || item[:title]
    end
end

def thumbnail_for item
    thumbnail = if item[:thumbnail]
                    @items[item.path+item[:thumbnail]]
                else
                    @items[item.path+"*thumbnail*{png,jpg,gif,svg}"] ||
                        @items[item.path+"*talk*.pdf"] ||
                        @items[item.path+"*.{png,jpg,gif,svg,pdf}"]
                end

    if thumbnail && thumbnail.reps[:thumbnail]
        thumbnail.reps[:thumbnail].path
    else
        ""
    end
end

def with_tag tag
    things.select do |item|
        item[:tags] and item[:tags].include? tag
    end
end

def domain
    "https://ateliersonnenschein.de/"
end

def box(items)
    ret = "<div class=\"boxes\">"
    items.each do |item|
        ret << render("/box.*", {:item => item})
    end
    ret << "</div>"
    ret
end

def eventbox(items)
    ret = "<div class=\"boxes\">"
    items.each do |item|
        ret << render("/eventbox.*", {:item => item})
    end
    ret << "</div>"
    ret
end

def gallerybox(items)
    ret = "<div class=\"boxes\">"
    items.each do |item|
        ret << render("/gallerybox.*", {:item => item})
    end
    ret << "</div>"
    ret
end

def newest_first(items)
    items.select{|i| i[:updated] || i[:published] }.sort_by{|i| i[:updated] || i[:published]}.reverse
end
