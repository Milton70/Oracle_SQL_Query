require 'oci8'
require 'byebug'

conn = OCI8.new('BHATVI', 'W3dnesd4y', 'UAT1')

# parse and exec the statement
cursor = conn.parse("select * from bphadmin.account where rownum <= 5")
cursor.exec

# output column names
puts cursor.getColNames.join(",")

# output rows
while r = cursor.fetch 
	puts r.join(",")
end

# close the cursor and logoff
cursor.close
conn.logoff