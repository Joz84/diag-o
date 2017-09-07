var map;
var geocoder; //Added on 27/09/2016
var marker;
var polygon;
var bounds;

window.onload = initMap;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: center,
    zoom: 14,
    scaleControl: true,
    center: {lat: 41.3749971 , lng: 2.1669979},
    disableDefaultUI: false
  });
  geocoder = new google.maps.Geocoder(); //Added on 27/09/2016
  bounds = new google.maps.LatLngBounds();
  google.maps.event.addListenerOnce(map, 'tilesloaded', function(evt) {
    bounds = map.getBounds();
  });
    marker = new google.maps.Marker({
      position: center
    });
    polygon = new google.maps.Polygon({
    path: area,
    geodesic: true,
    strokeColor: '#FFd000',
    strokeOpacity: 1.0,
    strokeWeight: 4,
    fillColor: '#FFd000',
    fillOpacity: 0.35
  });

  polygon.setMap(map);

  var input = /** @type {!HTMLInputElement} */(
    document.getElementById('pac-input'));
        var types = document.getElementById('type-selector');
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

        var autocomplete = new google.maps.places.Autocomplete(input);
        autocomplete.addListener('place_changed', function() {
    marker.setMap(null);
    var place = autocomplete.getPlace();
    var newBounds = new google.maps.LatLngBounds(bounds.getSouthWest(), bounds.getNorthEast()); //Changed
    // removed newBounds = bounds;
          if (!place.geometry) {
            geocodeAddress(input.value);//Added on 27/09/2016
            //window.alert("Autocomplete's returned place contains no geometry");
            return;
          };
      marker.setPosition(place.geometry.location);
      marker.setMap(map);
      newBounds.extend(place.geometry.location);
      map.fitBounds(newBounds);
      if (google.maps.geometry.poly.containsLocation(place.geometry.location, polygon)){
      alert('The area contains the address');
      } else {
      alert('The address is outside of the area.');
      };
     });
}
//Added on 27/09/2016
//*************************
function geocodeAddress(addr) {
  geocoder.geocode({'address': addr}, function(results, status) {
    if (status === 'OK') {
      var newBounds = new google.maps.LatLngBounds(bounds.getSouthWest(), bounds.getNorthEast());
      marker.setPosition(results[0].geometry.location);
      marker.setMap(map);
      newBounds.extend(results[0].geometry.location);
      map.fitBounds(newBounds);
      if (google.maps.geometry.poly.containsLocation(results[0].geometry.location, polygon)){
      alert('The area contains the address');
      } else {
      alert('The address is outside of the area.');
      };
    } else {
    alert('Geocode was not successful for the following reason: ' + status);
    }
  });
};
//*************************

var center = new google.maps.LatLng(41.3899621, 2.1469796);
var area= [
{lat: 41.3749971 , lng: 2.1669979},
{lat: 41.3749569 , lng: 2.1683179},
{lat: 41.3759391 , lng: 2.1690059},
{lat: 41.3780967 , lng: 2.1652293},
{lat: 41.3777424 , lng: 2.1645641},
{lat: 41.380383 , lng: 2.1611738},
];
