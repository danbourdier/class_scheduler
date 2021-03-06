class ReviewDecorator
  include ActionView::Helpers::DateHelper

  attr_reader :review

  def initialize(review, opts={ })
    @review, @reviewee_first_name, @reviewer = review, opts[:reviewee_first_name], opts[:reviewer]
  end

  def simple_decorate
    {
        :review => review,
        :id => id,
        :comment => comment
    }
  end

  def decorate
    {
        :comment => comment,
        :review => review,
        :created_at => created_at,
        :reviewee => reviewee_first_name,
        :reviewer_url_slug => reviewer_url_slug,
        :reviewer_first_name => reviewer_first_name
    }
  end

  def comment
    @review && @review[:comment] || ''
  end

  def review
    @review && @review[:review] || 0
  end

  def id
    @review && @review[:id] || nil
  end

  def created_at
    time_ago_in_words(@review.updated_at)
  end

  def reviewer
    @reviewer ||= User.find(@review[:author_id])
  end

  def reviewer_first_name
    reviewer[:first_name] ||= ''
  end

  def reviewee_first_name
    @reviewee_first_name ||= User.find(@review[:user_id]).first_name
  end

  def reviewer_url_slug
    reviewer[:url_slug] ||= ''
  end
end
