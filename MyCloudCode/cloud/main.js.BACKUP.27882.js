
//For Parse hosting
//require('cloud/app.js');

tripApiKey = "HackTripAdvisor-ade29ff43aed"
tripBaseUrl = "http://api.tripadvisor.com/api/partner/2.0/"

// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

function getLocationID(lat, longitude) {
    tripUrl =  "map/" + lat + "," + longitude;
    url = tripBaseUrl + tripUrl;
    return Parse.Cloud.httpRequest({
    	url: url,
    	params: {
    			key: tripApiKey
    	}
    });
};

function getPhotos(attraction_id) {
    tripUrl =  "location/" + attaction_id + "/photos";
    url = tripBaseUrl + tripUrl;
    return Parse.Cloud.httpRequest({
    	url: url,
    	params: {
    			key: tripApiKey
    	}
    });
};
/*
function getPageInfo(locationID) {
	console.log("In page info:");
	
	// this returns a dictionary with photos, 
	// location, description, rating, num ratings,
	// title, country photo. etc. for app to
	// display.

	/*
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
	/
*/

// request.params.locationData -> {oldData: {lat, long}}
Parse.Cloud.define("getTripData", function(request, response) {
	console.log("this is a test:", request.params.locationData);
	oldCoord = request.params.locationData['newCoord']
	getLocationID(42.33141, -71.099396).then( function(results) {
		tripData = JSON.parse(results.text);
		city_id = tripData["data"][0]["ancestors"][0]["location_id"];
		console.log("city_id: " + city_id);
<<<<<<< HEAD
		response.success(tripData["data"]);
		/*
		getAttraction(city_id).then( function(results) {
				console.log("Got attraction: ");
				tripData = JSON.parse(results.text);
				attraction = tripData["data"][0]; 
				//console.log(attraction);
				info = {};
				//info ["location"] = attraction["location_string"];
				console.log(info);
				//info ["description"] = attraction["description_string"];
				//info ["rating"] = attraction["rating_string"];
				info ["num_reviews"] = attraction["review_string"];
				info ["title"] = attraction["name_string"];
				console.log(info);
				response.success(info);
		
		//getPhoto(attraction["location_id"]).then( function(results) {
			//info ['photos']
		//}
		});*/
	});
=======
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
                response.success(info);
        });
>>>>>>> origin/master
    //console.log(locID)
	//info = getPageInfo(locID)
});

function getAttraction(location_id) {
    tripUrl =  "location/" + location_id + "/attractions";
    url = tripBaseUrl + tripUrl;
    return Parse.Cloud.httpRequest({
    	url: url,
    	params: {
    			key: tripApiKey
    	}
    });
};

