module PostsHelper
  def display_likes(post)
    votes = post.votes_for.up
    if votes.size <= 8
      return list_likers(votes)
    else
      count_likers(votes)
    end
  end

  def liked_post(post)
    if post.liked_by(current_user)
      return 'glyphicon-heart'
    else
      return 'glyphicon-heart-empty'
    end
  end

  private

  def list_likers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.username, profile_path(voter.username), class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
