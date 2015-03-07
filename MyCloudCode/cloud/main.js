
//For Parse hosting
//require('cloud/app.js');

tripApiKey = "?=HackTripAdvisor-ade29ff43aed"
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
    var req = new XMLHttpRequest();
    req.open("GET" tripApiKey + lat + "," + long + tripBaseUrl, false);
    req.send();
    var tripData = JSON.parse(req.responseText);
    return tripData["data"][0]["location_id"];
};

function getPageInfo(locationID) {
	// this returns a dictionary with photos, 
	// location, description, rating, num ratings,
	// title, country photo. etc. for app to
	// display.

	// TODO: hardcoded. Returns test dictionary
	info = {
		'location': 'Boston, Massachusetts',
		'description': 'walk here for a while, you know, do stuff',
		'rating': 5,
		'number_ratings': 200,
		'title': 'Freedom Trail',
		'photos': ['http://e2.tacdn.com/cds/media/photo-f/01/b7/79/d3/freedom-trail-sidewalk.jpg'],
		'country_photos': ['http://e2.tacdn.com/cds/media/photo-f/01/58/ab/a5/the-view.jpg']
		}
	
	return info;
};

function getPhotos(attraction_id, info) {
    tripUrl =  "location/" + attraction_id + "/photos";
    url = tripBaseUrl + tripUrl;
    tripData = Parse.Cloud.httpRequest({
    	url: url,
    	params: {
    			key: tripApiKey
    	}
    });

    info['photos'] = parseForPhotos(tripData);
    console.log('photos \n');
    console.log(info['photos']);
    return info;
};

function parseForPhotos(tripData) {
	photos = [];
	//for (var i in tripData['data']) {
		//photo_url = tripData['data'][0]['large']['url'];
		console.log(tripData['data']);
		//console.log(photo_url);
	//	photos.push(photo_url);
	//}
	return photos;
};

// request.params.locationData -> {oldData: {lat, long}}
Parse.Cloud.define("getTripData", function(request, response) {
	console.log("this is a test:", request.params.locationData);
	oldCoord = request.params.locationData['newCoord']
	getLocationID(42.33141, -71.099396).then( function(results) {
		tripData = JSON.parse(results.text);
		city_id = tripData["data"][0]["ancestors"][0]["location_id"];
		console.log("city_id: " + city_id);
		//response.success(tripData["data"]);
		return getAttraction(city_id);
	}).then(function(city_results) {
                //console.log("Got attraction: ");
                tripData = JSON.parse(city_results.text);
                //console.log("city results \n");
                //console.log(city_results.text)
                attraction = tripData["data"][0]; 
                console.log("attraction \n");
                console.log(attraction);
                console.log(attraction.review_string);
                info = {};
                //info ["location"] = attraction["location_string"];
                console.log(info);
                //info ["description"] = attraction["description_string"];
                //info ["rating"] = attraction["rating_string"];
                info ["num_reviews"] = attraction["review_string"];
                info ["title"] = attraction["name_string"];
                console.log("info 2 \n");
                console.log(info);
                return info;
        }).then(function(info) {
        		console.log(info);
                response.success(info);
        });
    //console.log(locID)
	//info = getPageInfo(locID)
});


