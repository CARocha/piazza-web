# frozen_string_literal: true

# title for each page
module ApplicationHelper
  def title
    return t('piazza') unless content_for?(:title)

    "#{content_for(:title)} | #{t('piazza')}"
  end
end
