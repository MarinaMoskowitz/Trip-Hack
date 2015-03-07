//For Parse hosting
require('cloud/app.js');

tripApiKey = "HackTripAdvisor-ade29ff43aed"
tripBaseUrl = "http://api.tripadvisor.com/api/partner/2.0/"

// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

function getLocationID(lat, long) {
	// this returns location ID from trip api call
	// TODO: this is hardcoded test data
	// 	 that returns Boston locID
	return 60745
};

function getPageInfo(locationID) {
	// this returns a dictionary with photos, 
	// location, description, rating, num ratings,
	// title, country photo. etc. for app to
	// display.

	// TODO: hardcoded. Returns test dictionary
	info = {
		'location': 'Boston, Massachusetts',
		'description': 'walk here for a while, you know, do stuff'',
		'rating': 5,
		'number_ratings': 200,
		'title': 'Freedom Trail',
		'photos': ['http://e2.tacdn.com/cds/media/photo-f/01/b7/79/d3/freedom-trail-sidewalk.jpg'],
		'country_photos': ['http://e2.tacdn.com/cds/media/photo-f/01/58/ab/a5/the-view.jpg']
		}
	
	return info;
};

// request.params.locationData -> {oldData: {lat, long}}
Parse.Cloud.define("getTripData", function(request, response) {
	console.log("this is a test:", request.params.locationData);
	newCoord = request.params.locationData['newCoord']
	locID = getLocationID(newCoord['lat'], newCoord['long'])
	info = getPageInfo(locID)
	response.success(info)
});

