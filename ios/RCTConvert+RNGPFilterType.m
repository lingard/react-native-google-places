#import "RCTConvert+RNGPFilterType.h"

@implementation RCTConvert (RNPStatus)

RCT_ENUM_CONVERTER(kGMSPlacesAutocompleteTypeFilter,
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
