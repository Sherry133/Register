/** @format */

// Require the xml2js module to convert JSON to XML
const xml2js = require('xml2js');

function generateUuidv4() {
	const currentDate = new Date().toISOString().slice(0, 10).replace(/-/g, ''); // Get current date in the format 'YYYYMMDD'
	const identifier = '725060066'; // Your nine-digit identifier
	const reference = generateRandomReference(18); // Generate a random alphanumeric reference up to 18 characters

	return currentDate + identifier + reference;
}

function generateRandomReference(length) {
	const characters =
		'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	let reference = '';

	for (let i = 0; i < length; i++) {
		const randomIndex = Math.floor(Math.random() * characters.length);
		reference += characters[randomIndex];
	}

	return reference;
}

// const currentDate = new Date().toISOString().slice(0, 10);
const currentDate = new Date().toISOString().slice(0, 19) + 'Z';

const creationDate =
	new Date().getFullYear() +
	'-' +
	('0' + (new Date().getMonth() + 1)).slice(-2) +
	'-' +
	('0' + new Date().getDate()).slice(-2) +
	'T' +
	('0' + new Date().getHours()).slice(-2) +
	':' +
	('0' + new Date().getMinutes()).slice(-2) +
	':' +
	('0' + new Date().getSeconds()).slice(-2) +
	'.' +
	('00' + new Date().getMilliseconds()).slice(-3);

// Define the JSON object that contains the transfer information. (Currently data are hard-coded.)

// Define the XML object that represents the pain.013 message structure
const pain014 = {
	Document: {
		$: {
			// Specify the XML namespace and schema for pain.013
			xmlns: 'urn:iso:std:iso:20022:tech:xsd:pain.014.001.07',
			'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
			'xsi:schemaLocation':
				'urn:iso:std:iso:20022:tech:xsd:pain.014.001.07 RequestForPayment_pain_014_001_07.xsd',
		},
		// Specify the message header information
		CdtrPmtActvtnReqStsRpt: {
			GrpHdr: {
				// Specify the message identification using the transfer reference id
				// MsgId: new Date().toISOString().slice(0, 10) + "-" + uuidv4(),
				MsgId: generateUuidv4(),

				// Specify the creation date and time of the message
				CreDtTm: creationDate,
				// // Specify the initiating party information using the source customer reference id
				InitgPty: {
					Nm: 'Photon Commerce',
				},

				//This is the debtor's bank information section
				DbtrAgt: {
					// Specify the debtor's bank information using the source account reference id
					FinInstnId: {
						// Specify the FRB's information using their ABA id
						ClrSysMmbId: {
							// Specify the FRB's information using their ABA id
							ClrSysId: {
								Cd: 'USABA',
							},

							// Specify theDebtor Agrnt's information using their ABA id
							MmbId: '021020078',
						},
						Nm: 'Bank A',
					},
				},

				//This is the creditor section

				CdtrAgt: {
					// Specify the creditor's bank information using the source account reference id
					FinInstnId: {
						// Specify the FRB's information using their ABA id
						ClrSysMmbId: {
							// Specify the FRB's information using their ABA id
							ClrSysId: {
								Cd: 'USABA',
							},

							MmbId: '987654321',
						},
						Nm: 'Bank B',
					},
				},
			},
			//End of Group Header Section
			OrgnlGrpInfAndSts: {
				OrgnlMsgId: 817868805043344593022214860,
				OrgnlMsgNmId: 'pain.013.001.07',
				OrgnlCreDtTm: 2023 - 04 - 26 - 13 - 24 - 40.494,
			},
			OrgnlPmtInfAndSts: {
				OrgnlPmtInfId: 2023 - 04 - 26,
				TxInfAndSts: {
					TxSts: 'ACTC',
				},
			},
		},
	},
};

// Create a new xml2js builder object
const builder = new xml2js.Builder();

// Convert the XML object to a string
const xml = builder.buildObject(pain014);

const uuid = generateUuidv4();
// console.log(uuid); // e.g. "12345678abcdef1234567890123456789"

// Print the XML string to the console
console.log(xml);
