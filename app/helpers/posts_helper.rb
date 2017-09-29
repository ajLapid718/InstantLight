module PostsHelper
  def likers_of(post)
    votes = post.votes_for.up #.by_type(User)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.username, profile_path(voter.username), class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def liked_post(post)
    return 'glyphicon-heart' if current_user.voted_for?(post) # voted_for is from acts_as_voter, which we'll add in a bit
    'glyphicon-heart-empty' # else
  end

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
