class Movie < ActiveRecord::Base

  class Movie::InvalidKeyError < StandardError ; end

  def self.api_key
    'a44453783e4b756d1f207d0ed27c840c' # replace with my own Tmdb key asap
  end

  def self.find_in_tmdb(string)
    Tmdb.api_key = self.api_key
    begin
      TmdbMovie.find(:title => string)
    rescue ArgumentError => tmdb_error
      raise Movie::InvalidKeyError, tmdb_error.message
    rescue RuntimeError => tmdb_error
      if tmdb_error.message =~ /status code '404'/
        raise Movie::InvalidKeyError, tmdb_error.message
      else
        raise RuntimeError, tmdb_error.message
      end
    end
  end
end
