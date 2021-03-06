//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

//#import "PhoneNumber.h"
#import <UIKit/UIKit.h>
//#import <libPhoneNumberiOS/libPhoneNumberiOS.h>
#import <libPhoneNumberiOS/NBPhoneNumber.h>
#import <libPhoneNumberiOS/NBPhoneNumberUtil.h>
NS_ASSUME_NONNULL_BEGIN

@interface PhoneNumberUtil : NSObject

@property (nonatomic, retain) NBPhoneNumberUtil *nbPhoneNumberUtil;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)sharedThreadLocal;

+ (BOOL)name:(NSString *)nameString matchesQuery:(NSString *)queryString;

+ (NSString *)callingCodeFromCountryCode:(NSString *)countryCode;
+ (nullable NSString *)countryNameFromCountryCode:(NSString *)countryCode;
+ (NSArray <NSString *>*)countryCodesForSearchTerm:(nullable NSString *)searchTerm;

// Returns a list of country codes for a calling code in descending
// order of population.
- (NSArray<NSString *> *)countryCodesFromCallingCode:(NSString *)callingCode;
// Returns the most likely country code for a calling code based on population.
- (NSString *)probableCountryCodeForCallingCode:(NSString *)callingCode;

+ (NSUInteger)translateCursorPosition:(NSUInteger)offset
                                 from:(NSString *)source
                                   to:(NSString *)target
                    stickingRightward:(bool)preferHigh;

+ (NSString *)examplePhoneNumberForCountryCode:(NSString *)countryCode;

- (nullable NBPhoneNumber *)parse:(NSString *)numberToParse defaultRegion:(NSString *)defaultRegion error:(NSError **)error;
- (NSString *)format:(NBPhoneNumber *)phoneNumber
        numberFormat:(NBEPhoneNumberFormat)numberFormat
               error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
