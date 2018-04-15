var googleMapStyle = [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "simplified"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "all",
    "stylers": [
        {
            "visibility": "off"
        }
    ]
  },
  {
    "featureType": "road",
    "elementType": "all",
    "stylers": [
        {
            "saturation": "-100"
        },
        {
            "visibility": "on"
        }
    ]
  },
  {
      "featureType": "road",
      "elementType": "geometry.fill",
      "stylers": [
          {
              "visibility": "on"
          },
          {
              "color": "#ffffff"
          }
      ]
  },
  {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
          {
              "color": "#7f7b79"
          }
      ]
  },
  {
      "featureType": "road",
      "elementType": "labels.text.stroke",
      "stylers": [
          {
              "visibility": "off"
          }
      ]
  },
  {
      "featureType": "road",
      "elementType": "labels.icon",
      "stylers": [
          {
              "visibility": "off"
          }
      ]
  },
  {
      "featureType": "road.highway",
      "elementType": "all",
      "stylers": [
          {
              "visibility": "simplified"
          }
      ]
  },
  {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [
          {
              "color": "#7f7b79"
          }
      ]
  },
  {
      "featureType": "road.highway",
      "elementType": "labels.text.stroke",
      "stylers": [
          {
              "visibility": "off"
          }
      ]
  },
  {
      "featureType": "road.arterial",
      "elementType": "all",
      "stylers": [
          {
              "lightness": "30"
          }
      ]
  },
  {
      "featureType": "road.arterial",
      "elementType": "labels",
      "stylers": [
          {
              "visibility": "on"
          }
      ]
  },
  {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [
          {
              "color": "#7f7b79"
          }
      ]
  },
  {
      "featureType": "road.arterial",
      "elementType": "labels.text.stroke",
      "stylers": [
          {
              "visibility": "off"
          }
      ]
  },
  {
      "featureType": "road.local",
      "elementType": "all",
      "stylers": [
          {
              "lightness": "40"
          }
      ]
  },
  {
      "featureType": "road.local",
      "elementType": "labels",
      "stylers": [
          {
              "visibility": "off"
          }
      ]
  },
  {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
          {
              "visibility": "on"
          },
          {
              "color": "#858585"
          }
      ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#a4eaf4"
      }
    ]
  }
];


// Sets the map on all markers in the array.
function setMapOnAll(map, markers) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers(markers) {
  setMapOnAll(null, markers);
}

// Shows any markers currently in the array.
function showMarkers(map, markers) {
  setMapOnAll(map, markers);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers(markers) {
  clearMarkers(markers);
  markers = [];
}

function deleteMarker(marker) {
  if(marker){
    marker.setMap(null);
    marker = null;
  }
}

function setMarkersIcon(markers, icon) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setIcon(icon);
  }
}

function openMarkersInfowindow(markers) {
  for (var i = 0; i < markers.length; i++) {
    if(markers[i].infowindow){
      markers[i].infowindow.open(map, markers[i]);
    }
  }
}

function closeMarkersInfowindow(markers) {
  for (var i = 0; i < markers.length; i++) {
    if(markers[i].infowindow){
      markers[i].infowindow.close(map, markers[i]);
    }
  }
}

var userCurrentPos = {
  lat: 0.0,
  lng: 0.0
};

function hasUserCurrentPos(){
  if(userCurrentPos.lat!=0.0 && userCurrentPos.lng!=0.0){
    return true;
  }
  return false;
}

function promiseCalculateDisDur(des){
  var promise = new Promise(function(resolve, reject) {
    var results = {
      distance: null,
      duration: null,
      status: false
    }
    if(!hasUserCurrentPos()){
      resolve(results);
    }
    else{
      var directionsServiceCalc = new google.maps.DirectionsService;
      var start = new google.maps.LatLng(userCurrentPos.lat, userCurrentPos.lng);
      var end = new google.maps.LatLng(des.lat, des.lng);
      directionsServiceCalc.route({
        origin: start,
        destination: end,
        travelMode: 'DRIVING',
        avoidHighways: true
      }, function(response, status) {
        if (status === 'OK') {
          results.distance = response.routes[0].legs[0].distance.text;
          results.duration = response.routes[0].legs[0].duration.text;
          results.status = true;
          resolve(results);
        } else {
          reject('Directions request failed due to ' + status);
        }
      });
    }
  });

  return promise;
}

function createMilestone(route, dist){
  var milestones = [];
  var markers=[],
      geo = google.maps.geometry.spherical,
      path = route.overview_path,
      point = path[0],
      distance = 0,
      leg,
      overflow,
      pos;
            
  for(var p=1;p<path.length;++p){ 
    leg=Math.round(geo.computeDistanceBetween(point,path[p]));
    d1=distance+0
    distance+=leg;        
    overflow=dist-(d1%dist);
    
    if(distance>=dist && leg>=overflow){
      if(overflow && leg>=overflow){ 
        pos=geo.computeOffset(point,overflow,geo.computeHeading(point,path[p]));
        milestones.push({lat: pos.lat(), lng: pos.lng()});
        distance-=dist;
      }
      
      while(distance>=dist){ 
        pos=geo.computeOffset(point,dist+overflow,geo.computeHeading(point,path[p]));
        milestones.push({lat: pos.lat(), lng: pos.lng()});
        distance-=dist;
      }
    }
    point=path[p];
  }

  return milestones;    
}


var toggleFriendlyStore = false;
function FriendlyStoreControl(controlDiv, map) {

  // Set CSS for the control border.
  var controlUI = document.createElement('div');
  controlUI.style.backgroundColor = '#77D6AC';
  controlUI.style.borderRadius = '15px';
  controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
  controlUI.style.cursor = 'pointer';
  controlUI.style.marginLeft = '18px';
  controlUI.style.marginBottom = '8px';
  controlUI.style.textAlign = 'center';
  controlUI.title = 'Click to recenter the map';
  controlDiv.appendChild(controlUI);

  // Set CSS for the control interior.
  var controlText = document.createElement('div');
  controlText.style.color = '#FFFFFF';
  controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
  controlText.style.fontSize = '14px';
  controlText.style.lineHeight = '32px';
  controlText.style.paddingLeft = '10px';
  controlText.style.paddingRight = '10px';
  controlText.innerHTML = '友好店家';
  controlUI.appendChild(controlText);

  // Setup the click event listeners: simply set the map to Chicago.
  controlUI.addEventListener('click', function() {
    displayFriendlyStores();
    toggleFriendlyStore = !toggleFriendlyStore;
    if(toggleFriendlyStore){
      showMarkers(map, friendlyStoreMarkers);
      controlText.style.color = '#77D6AC';
      controlUI.style.backgroundColor = '#FFFFFF';
    }
    else{
      clearMarkers(friendlyStoreMarkers);
      controlText.style.color = '#FFFFFF';
      controlUI.style.backgroundColor  = '#77D6AC';
    }
  });

}

var toggleGostationSite = false;
function GostationSiteControl(controlDiv, map) {

  // Set CSS for the control border.
  var controlUI = document.createElement('div');
  controlUI.style.backgroundColor = '#77D6AC';
  controlUI.style.borderRadius = '15px';
  controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
  controlUI.style.cursor = 'pointer';
  controlUI.style.marginLeft = '18px';
  controlUI.style.marginBottom = '8px';
  controlUI.style.textAlign = 'center';
  controlUI.title = 'Click to recenter the map';
  controlDiv.appendChild(controlUI);

  // Set CSS for the control interior.
  var controlText = document.createElement('div');
  controlText.style.color = '#FFFFFF';
  controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
  controlText.style.fontSize = '14px';
  controlText.style.lineHeight = '32px';
  controlText.style.paddingLeft = '10px';
  controlText.style.paddingRight = '10px';
  controlText.innerHTML = '推薦景點';
  controlUI.appendChild(controlText);

  // Setup the click event listeners: simply set the map to Chicago.
  controlUI.addEventListener('click', function() {
    displayGostations();
    displaySites();
    toggleGostationSite = !toggleGostationSite;
    if(toggleGostationSite){
      setMarkersIcon(siteMarkers, i_site);
      openMarkersInfowindow(siteMarkers);
      setMarkersIcon(gostationMarkers, i_green_black_battery_sm);
      controlText.style.color = '#77D6AC';
      controlUI.style.backgroundColor = '#FFFFFF';
    }
    else{
      setMarkersIcon(gostationMarkers, i_green_black_battery);
      setMarkersIcon(siteMarkers, i_site_sm);
      closeMarkersInfowindow(siteMarkers);
      controlText.style.color = '#FFFFFF';
      controlUI.style.backgroundColor  = '#77D6AC';
    }
  });

}


function checkLatLngNearby(pos_1, pos_2, nearbyDisTH) {
  var a = (pos_1.lat-pos_2.lat)*(pos_1.lat-pos_2.lat);
  var b = (pos_1.lng-pos_2.lng)*(pos_1.lng-pos_2.lng);

  if( Math.sqrt(a+b) < nearbyDisTH ){
    return true;
  }
  return false;
}

function getUserCurrentPosition(){
  var promise = new Promise(function(resolve, reject) {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        function(position){
          resolve(position)
        }
      );
    } else {
      reject("Can not get current position!");
    }
  });

  return promise;
}

function createGoogleMapDirUrl(start, end){
  return 'https://www.google.com/maps/dir/'+start+'/'+end;
}

function getDirectionUrl(destination){
  if(hasUserCurrentPos()){
    origin = userCurrentPos.lat+','+userCurrentPos.lng;
    return createGoogleMapDirUrl(origin, destination);
  }
  else{
    return createGoogleMapDirUrl('', destination);
  }
}



