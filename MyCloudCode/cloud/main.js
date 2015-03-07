
//For Parse hosting
//require('cloud/app.js');

tripApiKey = "HackTripAdvisor-ade29ff43aed"
tripBaseUrl = "http://api.tripadvisor.com/api/partner/2.0/"

// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

function getLocationID(lat, long) {
	// this returns location ID from trip api call
}

function getPageInfo(locationID) {
	// this returns a dictionary with attraction,
	// reviews, ratings, pictures, etc. for app to
	// display.
}

// request.params.locationData -> {oldData: {lat, long}}
Parse.Cloud.define("getTripData", function(request, response) {
	console.log("this is a test:", request.params.locationData);
});

