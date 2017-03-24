class Article < ActiveRecord::Base
   has_many  :comments, dependent: :destroy
   validates :title, presence: true,
                     length: { minimum: 5 }

   before_save :merge_article_author

   after_destroy :display_in_log

   def merge_article_author
       self.text = "Comment: " + self.text + " of [ " + self.title + " ]"
   end

   def display_in_log
       logger.error "Article [" + self.title + "] has been deleted"
   end

end
