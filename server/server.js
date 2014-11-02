// includes 
var express = require('express') ;
var bodyParser = require('body-parser') ;
var morgan = require('morgan') ;
var request = require('request') ;
var braintree = require('braintree') ;
var gateway = braintree.connect({
    environment:  braintree.Environment.Sandbox,
    merchantId:   'jx8xk4dn3gp33qds',
    publicKey:    'w39hrsjzwtqqgkp7',
    privateKey:   '9b468951ac4a708266c975be7c039e1d'
});

var app = express() ;
// Logging Crap
app.use(morgan('dev')) ;
// Parse JSON, URL, ETC.
app.use(bodyParser.urlencoded({extended: true})) ;
app.use(bodyParser.json()) ;

// Routes
app.get('/newUser', function(req, res) {
	request.post({url : 'https://blockchain.info/api/v2/create_wallet', 
	form: {api: , password: mylifeisdopeidodopeshit}}, function(err, httpResponseCode, body) {
	
	});
}) ;
/*
app.get('/newMerchant', function(req, res){
	var merchantAccountParams = {
		individual: {
		firstName: "Jane",
		lastName: "Doe",
		email: "jane@14ladders.com",
		phone: "5553334444",
		dateOfBirth: "1981-11-19",
		ssn: "456-45-4567",
		address: {
		  streetAddress: "111 Main St",
		  locality: "Chicago",
		  region: "IL",
		  postalCode: "60622"
		}
	  },
	  business: {
		legalName: "Jane's Ladders",
		dbaName: "Jane's Ladders",
		taxId: "98-7654321",
		address: {
		  streetAddress: "111 Main St",
		  locality: "Chicago",
		  region: "IL",
		  postalCode: "60622"
		}
	  },
	  funding: {
		descriptor: "Blue Ladders",
		destination: "bank",
		email: "funding@blueladders.com",
		mobilePhone: "5555555555",
		accountNumber: "1123581321",
		routingNumber: "071101307"
	  },
	  tosAccepted: true,
	  masterMerchantAccountId: "gqp8k6232xyb74xs",
	  id: "blue_ladders_store"
	};
	gateway.merchantAccount.create(merchantAccountParams, function(err, result) {
		console.log(result);
		if (err) {
			res.send(400, "Unknown Error");
			return;
		}
		res.send(200, "Success");
		return;
	});
}) ; */

// Edit the global listen env var so heroku knows where to put the server
app.listen(process.env.PORT || 5000) ;


