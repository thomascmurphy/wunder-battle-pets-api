class BattleJob < ApplicationJob
  queue_as :default

  def perform(contest)
    contest.battle()
  end
end
