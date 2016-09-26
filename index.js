import React from 'react'

import { NativeModules } from 'react-native'

const RNGooglePlacesNative = NativeModules.RNGooglePlaces

class RNGooglePlaces {
  autoCompleteQuery(query, filterType = 'noFilter') {
    return RNGooglePlacesNative.autoCompleteQuery(query, filterType)
  }

	openAutocompleteModal() {
		return RNGooglePlacesNative.openAutocompleteModal()
	}
}

export default new RNGooglePlaces()
