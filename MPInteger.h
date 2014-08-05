//
//  MPInteger.h
//  ClassProjects
//
//  Created by Emmanuel Ngeno on 7/30/13.
//  Copyright (c) 2013 Emmanuel Ngeno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPInteger : NSObject

//This will be needed by the instructor to test
//the code

//@property NSMutableString  *myStringNumber;

-(id) initWithString: (NSString *) x;
-(NSString *) description;

//main methods

-(MPInteger *) add : (MPInteger *) x;
-(MPInteger *) subtract : (MPInteger *) x;
-(MPInteger *) multiply : (MPInteger *) x;
-(MPInteger *) divideBy : (MPInteger *) x;
-(MPInteger *) modulus : (MPInteger *) x;

//Method to decode the secret message
-(BOOL) isLessThan: (MPInteger *) x;

@end
