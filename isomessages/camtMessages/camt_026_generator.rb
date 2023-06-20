class Camt026Generator
  require 'securerandom'
  require 'nokogiri'
  require 'dotenv/load'
  require 'active_support/core_ext/integer/time'

ASSIGNEE_ID = ENV.fetch('FEDNOW_ASSIGNEE_IDENTIFIER')

def self.camt_026_info_request_xml(data)

    doc = <<~EOF
      <Document xmlns="urn:iso:std:iso:20022:tech:xsd:camt.026.001.07" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:iso:std:iso:20022:tech:xsd:camt.026.001.07 InformationRequest_camt_026_001_07.xsd">

      	<UblToApply>
      		<Assgnmt>
      			  <Id>#{data['reference_id']}</Id>
      			<Assgnr>
      				<Agt>
      					<FinInstnId>
      						<ClrSysMmbId>
      							<ClrSysId>
      								<Cd>USABA</Cd>
      							</ClrSysId>
      							  <MmbId>#{data['member_id']}</MmbId>
      						</ClrSysMmbId>
      					</FinInstnId>
      				</Agt>
      			</Assgnr>
      			<Assgne>
      				<Agt>
      					<FinInstnId>
      						<ClrSysMmbId>
      							<ClrSysId>
      								<Cd>USABA</Cd>
      							</ClrSysId>
       <MmbId>#{data['assignee_id']}</MmbId>
      						</ClrSysMmbId>
      					</FinInstnId>
      				</Agt>
      			</Assgne>
      			  <CreDtTm>#{data['sender_creation_date_time']}</CreDtTm>
      		</Assgnmt>
      		<Case>
      			 <Id>#{data['original_request_id']}</Id>
      			<Cretr>
      				<Pty>
      					  <Nm>#{data['original_request_party_name']}</Nm>
                   <CtctDtls>
                        <PhneNb>#{data['original_request_party_contact_phone']}</PhneNb>
                        <PrefrdMtd>#{data['original_request_party_contact_method']}</PrefrdMtd>
                      </CtctDtls>
      				</Pty>
      			</Cretr>
      		</Case>
      		<Undrlyg>
      			<IntrBk>
      				<OrgnlGrpInf>
      					  <OrgnlMsgId>#{data['original_message_id']}</OrgnlMsgId>
      					  <OrgnlMsgNmId>#{data['original_message_name_id']}</OrgnlMsgNmId>
      					  <OrgnlCreDtTm>#{data['original_message_creation_date_time']}</OrgnlCreDtTm>
      				</OrgnlGrpInf>
      				<OrgnlInstrId>RFISc1Step1InstrId001</OrgnlInstrId>
      				<OrgnlEndToEndId>RFISc1Step1EtoEId001</OrgnlEndToEndId>
      				<OrgnlTxId>RFISc1Step1TransId001</OrgnlTxId>
      				<OrgnlIntrBkSttlmAmt Ccy="USD">45021.75</OrgnlIntrBkSttlmAmt>
      				<OrgnlIntrBkSttlmDt>2023-07-26</OrgnlIntrBkSttlmDt>
      			</IntrBk>
      		</Undrlyg>
      		<Justfn>
      			<MssngOrIncrrctInf>
      			<IncrrctInf>
      				<Cd>IN06</Cd>
      				<AddtlIncrrctInf>'The amount of the transfer is incorrect. Amount agreed after discount was $49,021.75. Please advise'</AddtlIncrrctInf>
      			</IncrrctInf>
      			</MssngOrIncrrctInf>
      		</Justfn>
      	</UblToApply>
      </Document>
    EOF

    puts doc
    File.write("./camt_026_info_request_#{Time.now.strftime('%Y%m%d%H%M%S')}.xml", doc.chomp)
  end

  def self.match_format?
    # Generate a unique message UUID
    SecureRandom.hex(16)

    # Return the generated UUID
  end

  def self.data_info_request
    data = {
      'message_UUID' => match_format?,
      'reference_id' => "#{Time.now.utc.strftime('%Y%m%d')}#{ENV.fetch('FEDNOW_PARTY_IDENTIFIER')}RFPSc04Stp3AMsgId",
      'member_id' => ENV.fetch('FEDNOW_PARTY_IDENTIFIER'),
      'assignee_id' => ASSIGNEE_ID,
      'sender_creation_date_time' => (Time.now.utc - 3.hours).iso8601,
      'original_request_id' => 'RFPSc04Step2Credit',
      'original_request_party_name' => 'Bank A Employee',
      'original_request_party_contact_phone' => '+1-88885553333',
      'original_request_party_contact_method' => 'PHON',
      'original_message_id' => "#{Time.now.utc.strftime('%Y%m%d')}#{ASSIGNEE_ID}RFPSc04Step2MsgId",
      'original_message_name_id' => 'pain.008.001.09',
      'original_message_creation_date_time' => Time.now.utc.iso8601,
      'original_end_to_end_id' => 'RFPSc04Step1EndToEndId001'
    }

    camt_026_info_request_xml(data)
    puts 'Hello SherBear'
  end
end

Camt026Generator.data_info_request
