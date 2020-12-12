# encoding: utf-8
namespace :linuxfr do
  desc "Daily crontab"
  task daily: [
    :delete_avatars_cache,
    :delete_old_passive_accounts,
    :daily_karma,
    :followup_almost_neglected_drafts,
    :erase_neglected_drafts,
    'sitemap:refresh'
  ]

  desc "New day => update karma and give new votes"
  task daily_karma: :environment do
    Account.find_each {|a| a.daily_karma }
  end

  desc "Followup almost neglected drafts"
  task followup_almost_neglected_drafts: :environment do
    message = "La dépêche semble abandonnée et sera automatiquement supprimée
      dans 2 semaines si aucune modification n'y est apportée."
    News.draft_to_followup.each do |news|
      NewsNotifications.followup(news, message).deliver_now
      Board.new(object_type: Board.news, object_id: news.id, message: message, user_name: "Le bot LinuxFr").save
    end
  end

  desc "Erase neglected news drafts"
  task erase_neglected_drafts: :environment do
    News.draft_to_refuse.each do |news|
      news.put_paragraphs_together
      news.erase!
      news.no_more_urgent!
      news.save
      NewsNotifications.erase_by_bot(news).deliver_now
    end
  end

  desc "Delete old accounts that were never activated"
  task delete_old_passive_accounts: :environment do
    Account.unconfirmed.where(["created_at <= ?", DateTime.now - 1.day]).destroy_all
  end

  desc "Delete the cache_dir for avatars (temporary stockage)"
  task delete_avatars_cache: :environment do
    CarrierWave.clean_cached_files!
  end

end
