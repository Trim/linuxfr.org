# encoding: UTF-8
module NewsHelper

  # Build at least 6 links for a news
  # and always add a blank new link,
  # so people without js can add as many links as they want
  # (one new per preview).
  def setup_news(news)
    (news.links.size ... 5).each { news.links.build }
    news.links.build
    news
  end

  def news_posted_by(news, is_index)
    informations = content_tag(:div, edited_by(news), class: "edited_by_spanblock")
    informations << content_tag(:div, moderated_by(news), class:"moderated_by_spanblock")
    details = content_tag(:summary, posted_by(news, is_index, news.node.user_id ? nil : news.author_name))
    if not(news.edited_by.to_a.none?) || news.moderator_id
      details << content_tag(:div, informations.html_safe, class: "posted_by_informations")
    end
    content_tag(:details, details, class: "posted_by_detailsblock", open: not(is_index)).html_safe
  end

  def edited_by(news)
    editors = news.edited_by.to_a
    return "" if editors.none?
    users = editors.map {|u| link_to(u.name, u) + " (" + u.login + ")" }.to_sentence
    "Édité par #{content_tag :span, users.html_safe, class: "edited_by"}.".html_safe
  end

  def moderated_by(news)
    return "" unless news.moderator_id
    moderator = User.where(id: news.moderator_id).select([:name, :cached_slug]).first
    account = Account.where(user_id: news.moderator_id).select([:login]).first
    "Modéré par #{link_to moderator.name, moderator} (#{account.login}).".html_safe if moderator
  end

  def link_attr(link)
    attrs = { lang: link.lang }
    attrs["data-url"] = edit_redaction_link_path(link) if link.persisted?
    attrs
  end

end
