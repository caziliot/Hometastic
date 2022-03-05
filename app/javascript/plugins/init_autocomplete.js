import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('flat_address');
  const cityInput = document.getElementById('flat_city')
  const reconfigurableAddress = {
    type: 'address', // Search only for addresses names
    aroundLatLngViaIP: false // disable the extra search/boost around the source IP
  };
  const reconfigurableCity = {
    type: 'city', // Search only for addresses names
    aroundLatLngViaIP: false // disable the extra search/boost around the source IP
  };

  if (addressInput) {
    var addressPlace = places({
      container: addressInput,
      type: 'address',
      templates: {
        value: function (suggestion) {
          return suggestion.name;
        }
      }
    }).configure(reconfigurableAddress);

    addressPlace.on('change', function(e) {
      cityInput.value = e.suggestion.city
    })
  }
  if(cityInput){
    places({
      container: cityInput,
      type: 'city',
      templates: {
        value: function (suggestion) {
          return suggestion.name;
        }
      }
    }).configure(reconfigurableCity);
  }



};

export { initAutocomplete };
