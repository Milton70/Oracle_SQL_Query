require 'oci8'
require 'byebug'

conn = OCI8.new('BHATVI', 'W3dnesd4y', 'UAT1')

# parse and exec the statement
begin
	cursor = conn.parse("select * from bphadmin.ssi where publishingssiagent like 'TDOMUS4H%'")
	cursor.exec

	headers = []
	values = []
	temp = []

	# output column names
	cursor.getColNames.each do |col|
		headers.push(col)
	end

	# output rows
	while row = cursor.fetch 
		row.each do |value|
			temp.push(value)
		end
		values.push(temp)
		temp = []
	end

	# close the cursor and logoff
	cursor.close
	conn.logoff

	puts headers
	puts values
rescue => e
	puts e
	# close the cursor and logoff
	cursor.close
	conn.logoff
end
