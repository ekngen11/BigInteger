//
//  main.m
//  ClassProjects
//
//  Created by Emmanuel Ngeno on 7/30/13.
//  Copyright (c) 2013 Emmanuel Ngeno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPInteger.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        
        // the cipher text c:
        MPInteger *encodedMessage = [[MPInteger alloc] initWithString:
        @"7807512491293448839140145421143868935616117960859576537030545231939229"];
        
        // the exponent d:
        MPInteger *decryptionExponent = [[MPInteger alloc] initWithString:
        @"14159819751754191295236210600607154703246410818878465976176726439085425"];
        
        // the modulus n:
        MPInteger *modulusKey = [[MPInteger alloc] initWithString:
        @"27606985387162255149739023449107931668458716142620601169954803000803329"];
        
        // the decoded message consists of a string of upper case letters
        // represent by two digit ASCII.  Using RSA, message = c^d mod n.
        MPInteger *message;
        
        // we use the "square-and-multiply" algorithm to compute c^d mod n.
        // this algorithm works according to the observation that c^d is (c^2)^(d/2)
        // with an extra c on the outside if (d/2) has a remainder.
        MPInteger *theNumberZero = [[MPInteger alloc] initWithString:@"0"];
        MPInteger *theNumberOne = [[MPInteger alloc] initWithString:@"1"];
        MPInteger *theNumberTwo = [[MPInteger alloc] initWithString:@"2"];
        MPInteger *squaredPart = encodedMessage;
        MPInteger *multipliedPart = theNumberOne;
        MPInteger *reducedExponent = decryptionExponent;
        MPInteger *reducedExponentRemainder;
        
        do {
            
            // compute reduced exponent d/2 and remainder
            reducedExponentRemainder = [reducedExponent modulus:theNumberTwo];
            reducedExponent = [reducedExponent divideBy:theNumberTwo];
            
            NSLog(@"ReducedExponent %lu", [[reducedExponent description] length]);
            
            
            NSLog(@"--------------");
            
            // if the exponent is odd then we multiply the inside "c" to the
            // outside of the c^(d/2) calculation
            if ([theNumberZero isLessThan: reducedExponentRemainder])
                multipliedPart =
				[[multipliedPart multiply:squaredPart] modulus:modulusKey];
            NSLog(@"multiplied %@",[multipliedPart description]);
            
            // now we square the inside and proceed
             NSLog(@"--------------");
            
            squaredPart = [[squaredPart multiply:squaredPart] modulus:modulusKey];
            
            NSLog(@"squarePart %@",[squaredPart description]);
            
            // we stop when the reduced exponent is 2 or less
            
        } while ([theNumberOne isLessThan:reducedExponent]);
        
        // complete message calculation
        message = [[squaredPart multiply:multipliedPart] modulus:modulusKey];
        
        NSLog(@"message %lu",(unsigned long)[[message description] length]);
        
        // if it's the right length, print the message
        NSString *messageStr = [message description];
        if ([messageStr length] == 60) {
            for (int i = 0; i < 60; i += 2) {
                int character =
                [[messageStr substringWithRange:NSMakeRange(i, 2)] intValue];
                printf("%c",character);
            }
        } else
            NSLog(@"Decoded message is the wrong length -- keep trying.");
        
        

       
    }
    return 0;
}

