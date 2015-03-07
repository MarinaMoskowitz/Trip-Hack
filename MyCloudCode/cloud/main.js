
//For Parse hosting
//require('cloud/app.js');

tripApiKey = "HackTripAdvisor-ade29ff43aed"
tripBaseUrl = "http://api.tripadvisor.com/api/partner/2.0/"



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
		//console.log("city_id: " + city_id);
		return getAttraction(city_id);
	}).then(function(city_results) {
                console.log("Got attraction: ");
                tripData = JSON.parse(city_results.text);
                //console.log("city results \n");
                //console.log(city_results.text)
                attraction = tripData["data"][0]; 
                //console.log("attraction \n");
                //console.log(attraction);
                //console.log(attraction.review_string);
                info = {};
                info ["location"] = attraction["location_string"];
                //console.log(info);
                info ["description"] = attraction["description"];
                info ["rating"] = attraction["rating"];
                info ["num_reviews"] = attraction["num_reviews"];
                info ["title"] = attraction["name"];
                //console.log("info 2 \n");
                return getPhotos(attraction["location_id"],info);
        }).then(function(info) {
        		console.log(info);
                response.success(info);
        });
    //console.log(locID)
	//info = getPageInfo(locID)
});


