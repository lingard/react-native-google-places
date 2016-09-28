import React from 'react'

import { NativeModules } from 'react-native'

const RNGooglePlacesNative = NativeModules.RNGooglePlaces

class RNGooglePlaces {
  autoCompleteQuery(query, filterType = 'noFilter') {
    return RNGooglePlacesNative.autoCompleteQuery(query, filterType)
  }

  lookUpPlaceID(placeID) {
    return RNGooglePlacesNative.lookUpPlaceID(placeID)
  }

  openAutocompleteModal() {
  	return RNGooglePlacesNative.openAutocompleteModal()
  }
}

export default new RNGooglePlaces()
