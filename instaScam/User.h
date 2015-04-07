//
//  User.h
//  instaScam
//
//  Created by Timothy Mueller on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSString *fullName;
@property NSString *bio;
@property NSString *userName;
@property BOOL genderMale;
@property NSArray *followers;
@property NSArray *following;
@property NSArray *favorites;
@property NSData *imgData;



@end
