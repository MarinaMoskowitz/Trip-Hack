
//For Parse hosting
//require('cloud/app.js');

tripApiKey = "HackTripAdvisor-ade29ff43aed"
tripBaseUrl = "http://api.tripadvisor.com/api/partner/2.0/"

function getLocationID(lat, longitude) {
	// this returns location ID from trip api call
	// TODO: this is hardcoded test data
	// 	 that returns Boston locID
	tripUrl = "map/" + lat + "," + longitude;
	url = tripBaseUrl + tripUrl;
	return Parse.Cloud.httpRequest({
		url: url,
		params: {
			key: tripApiKey
		}
	});
};

function getAttraction(city_id) {
	// this returns location ID from trip api call
	// TODO: this is hardcoded test data
	// 	 that returns Boston locID
	tripUrl = "location/" + city_id + "/attractions";
	url = tripBaseUrl + tripUrl;
	return Parse.Cloud.httpRequest({
		url: url,
		params: {
			key: tripApiKey
		}
	});
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
                console.log("Got attraction: ");
                tripData = JSON.parse(city_results.text);
                //console.log("city results \n");
                //console.log(city_results.text)
                attraction = tripData["data"][0]; 
                console.log("attraction \n");
                //console.log(attraction);
                //console.log(attraction.review_string);
                info = {};
                info ["location"] = attraction["location_string"];
                console.log(info);
                info ["description"] = attraction["description"];
                info ["rating"] = attraction["rating"];
                info ["num_reviews"] = attraction["num_reviews"];
                info ["title"] = attraction["name"];
                console.log("info 2 \n");
                console.log(info);
                return info;
        }).then(function(info) {
                response.success(info);
        });
    //console.log(locID)
	//info = getPageInfo(locID)
});

