#import "RCTConvert+RNGPAutocompleteTypeFilter.h"
#import <GooglePlaces/GooglePlaces.h>

@implementation RCTConvert (RNGPAutocompleteTypeFilter)

RCT_ENUM_CONVERTER(GMSPlacesAutocompleteTypeFilter,
  (@{
    @"noFilter" : @(kGMSPlacesAutocompleteTypeFilterNoFilter),
    @"geocode" : @(kGMSPlacesAutocompleteTypeFilterGeocode),
    @"adress" : @(kGMSPlacesAutocompleteTypeFilterAddress),
    @"establishment" : @(kGMSPlacesAutocompleteTypeFilterEstablishment),
    @"region" : @(kGMSPlacesAutocompleteTypeFilterRegion),
    @"city" : @(kGMSPlacesAutocompleteTypeFilterCity),
  }),
  kGMSPlacesAutocompleteTypeFilterNoFilter, integerValue
)

@end
