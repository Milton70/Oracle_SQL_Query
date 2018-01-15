class Query < ApplicationRecord
	belongs_to :user

	validates :query_name, presence: true, uniqueness: true
	validates :query_description, presence: true
	validates :saved_query, presence: true
	validates :user_id, presence: true

	def self.execute_query(the_env, the_query)

		#headers = ['PAYMENTTRANSACTIONKEY','INCOMINGTRANSACTIONGROUPKEY','OUTGOINGTRANSACTIONGROUPKEY','INCOMINGINSTRUCTIONKEY','OPICKEY','BANKGROUPID','BANKKEY','OUTGINTCHGCLEARINGCNDTNKEY','OUTGINSTRSETTLEMENTPRTCPNTKEY',
		#	'OUTGINSTRBUSINESSPRTCPNTKEY','REJECTRECONCILIATIONKEY',	'CANCELRECONCILIATIONKEY',	'DISPLAYTRANSACTIONID',	'STATUS',	'DETAILS',	'PROCESSINGDETAILS',	'VERSION',	'WHENMODIFIED',	'PURGEDAY',	'PURGEDAY_DATE',
		#	'CLASSIFICATIONIDX',	'ENDTOENDIDIDX',	'FIRSTINSTRUCTINGAGENTTRNIDIDX',	'SETTLEMENTAMOUNTIDX',	'SETTLEMENTCURRENCYIDX',	'INCOMINGSETTLEMENTDAYIDX',	'SETTLEMENTDAYIDX',	'DEBITCREDITINDICATORIDX',
		#	'PROCESSINGSCHEMEIDX',	'INSTRUCTEDDAYIDX',	'RTRANSACTIONQUALIFICATIONIDX',	'ORIGINALENDTOENDIDIDX',	'PRIORITYIDX',	'DEBITPARTYNAMEIDX',	'DEBITPARTYACCOUNTIDX',	'DEBITPARTYAGENTIDIDX',
		#	'DEBITPARTYAGENT2IDIDX',	'DEBITPARTYAGENT3IDIDX',	'DEBITPARTYAGENT4IDIDX',	'DEBITPARTYAGENT5IDIDX',	'CREDITPARTYNAMEIDX',	'CREDITPARTYACCOUNTIDX',	'CREDITPARTYAGENTIDIDX',	'CREDITPARTYAGENT2IDIDX',
		#	'CREDITPARTYAGENT3IDIDX',	'CREDITPARTYAGENT4IDIDX',	'CREDITPARTYAGENT5IDIDX',	'PROCESSINGDAYIDX',	'ONUSFLAGIPX',	'DUPLICATECHECKHASHIPX',	'UNROUTABLEFROMINSTRUCTIONIPX',	'OUTBOUNDIPX',	'OMITTEDFLAGIPX',
		#	'RISKFILTERCHECKTIMESTAMPIPX',	'INSTRUCTINGAGENTTXNIDIDX',	'RTRANSACTIONFLAGIDX',	'RTRANSACTIONLEVELIDX',	'RTRANSACTIONPOSTSETLMNTFLAGIDX',	'RTRANSACTIONREFUNDFLAGIDX',	'ORIGFRSTINSTRUCTAGENTTXNIDIDX',
		#	'SEQUENCETYPEIDX',	'DEBITPARTYIDIDX',	'MANDATEREFERENCEIDX',	'MANDATEAMENDMENTFLAGIDX',	'MANDATEOLDDEBITPARTYACCOUNTIDX',	'MANDATEKEY',	'CREDITPARTYSCHEMEPARTYIDIDX',	'VALIDATEDBYPARTICIPANTIDX',	'SETTLEDIDX',
		#	'FOUREVADDITIONALREFUNDKEYIPX',	'TECHMANDATEREFERENCEIPX',	'TECHCRDTPRTYSCHMPRTYIDIPX',	'TECHCRDTPRTYSCHMPRTYIDTYPIPX',	'PRESETTLEMENTCANCELLEDIPX',	'REPRESENTATIONRECONCILTNIPX',	'INSTRUCTEDAMOUNTIDX',
		#	'INSTRUCTEDCURRENCYIDX',	'DEBITPARTYAGENTIDTYPEIDX',	'DEBITPARTYAGENT2IDTYPEIDX',	'CREDITPARTYAGENTIDTYPEIDX',	'CREDITPARTYAGENT2IDTYPEIDX',	'CURRENCYCONVERSIONSTATUSIPX',	'PAYMENTMETHODIPX',	'BANKPAYMENTTYPEKEY',
		#	'BANKINGACCOUNTKEY',	'RECEIVINGENTITYKEY',	'INCOMINGSETTLEMENTAMOUNTIDX',	'INCOMINGSETTLEMENTCURRENCYIDX',	'ATTACHMENTCOLLECTIONIDIDX',	'INSTRUCTINGAGENTTRNIDIDX',	'INCINSTRUCTINGAGENTTRNIDIDX',	'CARDPAN',
		#	'CARDEXPIRYDATE',	'MANDATEIDENTIFIER',	'CREDITORMANDATEKEY',	'LOCALINSTRUMENTCODEIDX',	'PVDRAGREEMENTAPPLICABLEIDX',	'PVDRRELEASEDATEIDX',	'PVDRAPTIDX','AGENTENDTOENDIDIDX']
		#values = [['525010813',nil,nil,'23490836','145307656','MHBK','-6','16263','61472','61472',nil,nil,'OPF525010813',nil,'"<?xml version=""1.0"" encoding=""UTF-8""?><Trn project=""11.151951"" solution=""8.133308"">
		#	<Cdtr><Nm>Seiko Optical GMBH		</Nm><PstlAdr><AdrLine>Siemenspring 111		</AdrLine><Ctry>US</Ctry><TwnNm>47877 Willich		</TwnNm></PstlAdr></Cdtr><CdtrAcct><AcctId><Id>15942587</Id><IdTp>Proprietary</IdTp></AcctId>
		#	</CdtrAcct><CdtrAgt><FinInstnId><Id><Id>TDOMUS4HXXX</Id><Tp>BIC</Tp></Id><Id><Id>USABA113017553</Id><Tp>CSM</Tp></Id><Id><Id>113017553</Id><Tp>USABA</Tp></Id><PstlAdr><Ctry>US</Ctry></PstlAdr></FinInstnId></CdtrAgt>
		#	<CdtrAgtAcct><AcctId><Id>148315</Id><IdTp>CUID</IdTp></AcctId></CdtrAgtAcct><ChrgBr>SHAR</ChrgBr><Chrgs><ChrgsAcct><Ccy>USD</Ccy><chrgsAcctSgmnt>NOTSET</chrgsAcctSgmnt></ChrgsAcct><ChrgsGCIF>542442</ChrgsGCIF>
		#	<ChrgsIntrnlAcct>F10143981-USD-20000</ChrgsIntrnlAcct></Chrgs><Clssfn>CreditTransfer</Clssfn><DbtCdtInd>C</DbtCdtInd><Dbtr><Nm>FGL AIRCRAFT IRELAND NO.  1 LIMITED</Nm><PstlAdr><AdrLine>2 GRAND CANAL SQUARE</AdrLine>
		#	<AdrLine>GRAND CANAL HARBOUR2</AdrLine><Ctry>IE</Ctry></PstlAdr></Dbtr><DbtrAcct><AcctId><Id>GB91MHCB40506910143981</Id><IdTp>IBAN</IdTp></AcctId></DbtrAcct><DbtrAgt><FinInstnId><Id><Id>MHCBGB2LXXX</Id><Tp>BIC</Tp>
		#	</Id><PstlAdr><Ctry>GB</Ctry></PstlAdr></FinInstnId></DbtrAgt><InIntrBkSttlmAmt Ccy=""USD"">458.26000</InIntrBkSttlmAmt><InSttlmDay>2018-01-11</InSttlmDay><InstdAgt><FinInstnId><Id><Id>BKTRUS33</Id><Tp>BIC</Tp></Id>
		#	</FinInstnId></InstdAgt><InstdAmt Ccy=""USD"">458.26000</InstdAmt><InstgAgt><FinInstnId><Id><Id>MHCBGB2L</Id><Tp>BIC</Tp></Id></FinInstnId></InstgAgt><IntrBkSttlmAmt Ccy=""USD"">458.26000</IntrBkSttlmAmt><IntrmyAgt1>
		#	<FinInstnId><Id><Id>CHASUS33XXX</Id><Tp>BIC</Tp></Id></FinInstnId></IntrmyAgt1><IsSTP>true</IsSTP><PmtTpInf><InstrPrty>NORM</InstrPrty></PmtTpInf><Sttlm><DlgtdSttlm><EPCount>0</EPCount></DlgtdSttlm><SttlmAcct><AcctId>
		#	<Id>F60805135-USD-09800</Id></AcctId><Ccy>USD</Ccy></SttlmAcct></Sttlm><SttlmDay>2018-01-11</SttlmDay><SttlmInf><SttlmAcct><Tp><Tp>NOSTRO</Tp></Tp></SttlmAcct><SttlmAcctAgt><FinInstnId><Id><Id>MHCBGB2L</Id><Tp>BIC</Tp>
		#	</Id></FinInstnId></SttlmAcctAgt></SttlmInf><TrnRef><EndToEndId>CKRETEST1452</EndToEndId><FrstInstgTrnId>OPF525010813</FrstInstgTrnId><IncmgInstgTrnId>CKRETEST1452</IncmgInstgTrnId><InstgTrnId>OPF525010813</InstgTrnId>
		#	</TrnRef></Trn>"','<?xml version="1.0" encoding="UTF-8"?><Trn solution="8.133308" project="11.151951"><Chrgs><EnrchdChrgsAccount>F10143981-USD-20000</EnrchdChrgsAccount><EnrchdChrgsAcctCcy>USD</EnrchdChrgsAcctCcy>
		#	<EnrchdChrgsGCIF>542442</EnrchdChrgsGCIF></Chrgs><EnrchdUsngSSI>true</EnrchdUsngSSI><ErlstSubmTm>1515542401000</ErlstSubmTm><ExpctdDwhsTm>1515556800000</ExpctdDwhsTm><FrEx><CdtAmt Ccy="USD">458.26000</CdtAmt>
		#	<DbtAmt Ccy="USD">458.26000</DbtAmt></FrEx><Imprtnc>5</Imprtnc><LtstSubmTm>1515689100000</LtstSubmTm><OnUs>false</OnUs><Outbound>true</Outbound><PrtyLvl>5</PrtyLvl><RgtRule>USD Currency</RgtRule><Rtg>
		#	<RtgCpdAgntFlg>false</RtgCpdAgntFlg><Schm>ICT</Schm><frstMtchdRl>18956</frstMtchdRl><instdAgtLnk>Participant</instdAgtLnk><mtchdRlKey>18956</mtchdRlKey></Rtg><RtgAcct><Id>148315</Id></RtgAcct><RtgAgt>
		#	<Id>TDOMUS4HXXX</Id><IdTp>BIC</IdTp><Lnk>CreditPartyAgent</Lnk></RtgAgt><SwftMTMsgMp>rO0ABXNyABFqYXZhLnV0aWwuSGFzaE1hcAUH2sHDFmDRAwACRgAKbG9hZEZhY3RvckkACXRocmVzaG9sZHhwP0AAAAAAAAx3CAAAABAAAAABdAADNTBGdAAxOjUwRjovR0I5MU1IQ0I0MDUwNjkxMDE0Mzk4MQ0KMS9ZT0tPSEFNQSANCjMvQUYNCng=</SwftMTMsgMp>
		#	<chapsFlag>true</chapsFlag><isPSDElig>false</isPSDElig></Trn>','8','10-Jan-18','11/01/2020','11-Jan-20','CreditTransfer','CKRETEST1452','OPF525010813','458.26','USD','11/01/2018','11/01/2018','C',nil,nil,nil,nil,
		#	'NORM','FGL AIRCRAFT IRELAND NO.  1 LIMITED','GB91MHCB40506910143981','MHCBGB2LXXX',nil,nil,nil,nil,'"Seiko Optical GMBH		"','15942587','TDOMUS4HXXX','USABA113017553','113017553',nil,nil,nil,'F',nil,nil,'T',nil,nil,
		#	'OPF525010813',nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,'458.26','USD','BIC',nil,'BIC','CSM',nil,nil,nil,nil,'-1','458.26','USD',nil,nil,'CKRETEST1452',nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]]							

		# See which environment we're dealing with
		env_vals = Environment.where(id: the_env).pluck(:db_user_id, :db_pwd)[0]

		# Try to make a connection
		begin
			conn = OCI8.new(env_vals[0], env_vals[1], Environment.where(id: the_env).pluck(:environment_name)[0])
		rescue
			return nil, nil, the_query, the_env
		end
		# parse and exec the statement
		begin

			# Add the bphadmin. to the table name so that the query works
			the_query = return_table_name(the_query)

			cursor = conn.parse(the_query)
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

		rescue => e
			# close the cursor and logoff
			cursor.close
			conn.logoff

			return "Query Failed", e, the_query, the_env
		end

		return headers, values, the_query, the_env
	
	end
	
	def self.return_table_name(the_query)
		
		# temp string for returning
		temp_string = ""

		# split the string by space
		query_split = the_query.split(' ')

		# Loop round until we find the from clause
		x = 0
		while x <= query_split.size - 1			
			# pre-pend bphadmin. to the table name, next element after from clause
			if query_split[x].downcase == "from"
				if !query_split[x + 1].include?("bphadmin")
					query_split[x + 1] = "bphadmin." + query_split[x + 1]
				end
			end
			if x == 0
				temp_string = query_split[x]
			else
				temp_string = temp_string + " " + query_split[x]
			end
			x += 1
		end

		# return the new string
		return temp_string
	end
end
