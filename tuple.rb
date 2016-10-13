class Tuple
  def intialize(commit, author, date)
    @commit = commit
    @author = author
    @date = date
  end

  def changeCommit(commit)
    @commit = commit
  end

  def changeAuthor(author)
    @author = author
  end

  def changeDate(date)
    @date = date
  end

  def getCommit
    return @commit
  end

  def getAuthor
    return @author
  end

  def getDate
    return @date
  end

  #function used for testing
  def printTuple
    if !(@author.nil? || @commit.nil? || @date.nil?)
      puts @commit + " " + @author + " " + @date
    end
  end
  
  #returns true when x is bigger than y
  def compare(x, y)
    return x.getDate > y.getDate
  end
end
