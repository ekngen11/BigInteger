//
//  MPInteger.m
//  ClassProjects
//
//  Created by Emmanuel Ngeno on 7/30/13.
//  Copyright (c) 2013 Emmanuel Ngeno. All rights reserved.
//

#import "MPInteger.h"




@implementation MPInteger


{
    NSMutableString *myStringNumber;
}


-(NSString *) description
{

    return myStringNumber;
}

//Initializes 
-(id) initWithString:(NSString *)x
{
    self= [super init];
    
    if (self){
        myStringNumber=[NSString stringWithString:x];
    }
    return self;
}

//Method that pads leading zeroes infront of a string

-(void) padthis:(MPInteger *)x toThis: (MPInteger *)y
{
    NSInteger xLen=[y->myStringNumber length]-[x->myStringNumber length];
    NSInteger yLen=[x->myStringNumber length]-[y->myStringNumber length];
    
    if (xLen>0){
        
        x->myStringNumber= [NSMutableString stringWithString:x->myStringNumber];
        
        for(NSInteger i=0;i<xLen;i++){
            [x->myStringNumber insertString:@"0" atIndex:0];
        }
        
    }
    else{
        y->myStringNumber= [NSMutableString stringWithString:y->myStringNumber];
        
        for(NSInteger i=0;i<yLen;i++){
            [y->myStringNumber insertString:@"0" atIndex:0];
        }
        
    }
}


- (NSMutableString *) removeLeadingZeros:(NSMutableString *)Instring
{
    NSMutableString *str2 =Instring ;
    
    for (int index=0; index<[Instring length]; index++)
    {
        if([str2 hasPrefix:@"0"] && !([str2 isEqualToString:@"0"]))
            str2 = [NSMutableString stringWithString:[str2 substringFromIndex:1]];
        else
            break;
    }
    return str2;
    
}


-(BOOL) isNegative:(MPInteger *) x
{
    char firstChar= [x->myStringNumber characterAtIndex:0];
    NSString *first= [NSString stringWithFormat:@"%c",firstChar];
    
    if ([first isEqualToString:@"-"]) {
        return YES;
    }
    else{
        return NO;
    }
        
}


//Method that claculates the sum of
//two MPIntegers

//Helper method for add
-(NSMutableString *) insertNegativeSign: (NSMutableString*) str
{
    NSMutableString *string= [[NSMutableString alloc] initWithString:str];
    [string insertString:@"-" atIndex:0];
    return string;
}

-(MPInteger *) add:(MPInteger *)x
{
    MPInteger *final;
    NSMutableString *finalString= [NSMutableString string];
    
    int carry=0;
    int firstNum;
    int secondNum;
    NSInteger i;
    int result;
    
    //Checks if the first MPInteger is negative and performs and undertakes
    //appropriate adjustments if so.
    
    if ([self isNegative:self]) {
        self->myStringNumber = [self->myStringNumber substringFromIndex:1];
        
        //Checks if the negative number is numerically more than the
        // positive number. If so it performs a subtraction and adds the
        //negative sign at the end of it.
        
        if ([x isLessThan:self]) {
            final = [self subtract:x];
            final->myStringNumber=[self insertNegativeSign:final->myStringNumber];
            
            //final = [[MPInteger alloc] initWithString:str];
        }
        
        //IF NOT THE ABOVE, Goes ahead and performs the subtraction of the negative number
        //from the positive
        else{
            final=[x subtract:self];
        }
        
    }
    
    else{
        
        NSInteger firstNumLen=[myStringNumber length];
        NSInteger secNumLen =[x->myStringNumber length];
    //Check if there is a difference in length
    //If so, pad the shorter string with leading zeros

        
        [self padthis:self toThis:x];
        
        
        
        firstNumLen=[myStringNumber length];
        
        //Looping through myStringNumber while adding each charater
        //storing the result.
        
        for (i=firstNumLen; i>0; i--){
            
            firstNum= [myStringNumber characterAtIndex:i-1]-'0';
            secondNum=[x->myStringNumber characterAtIndex:i-1]-'0';
            
            result= firstNum+secondNum+carry;
            
            if(i!=1){
                if (result>9) {
                    carry=1;
                    result=result-10;
                    if (i==0) {
                        result=result+10;
                    }
                }
                else{
                    carry=0;
                }
                
            }
                                
            NSString *stringInt= [NSString stringWithFormat:@"%i",result];
           
            [finalString insertString:stringInt atIndex:0];
            
        }
        //NSMutableString *reversedString=[self reverse:finalString];
        
        final= [[MPInteger alloc] initWithString:finalString];
        
        final->myStringNumber= [self removeLeadingZeros:final->myStringNumber];
    }
    return final;
}

//Method that caculates the difference between two
//MPIntegers


-(MPInteger *) subtract:(MPInteger *)x
{
    
    MPInteger *final;
    
    
    NSMutableString *finalString= [NSMutableString string];
    
    int borrow=0;
    int firstNum;
    int secondNum;
    NSInteger i;
    int result;
    NSInteger firstNumLen;
    NSInteger secNumLength;
    
    //Making sure the number you are subtracting from is more
    
    firstNumLen=[myStringNumber length];
    secNumLength= [x->myStringNumber length];
    
    //CASE1: If the number you are subtracting is negative.
    if ([self isNegative:self]){
        myStringNumber = [myStringNumber substringFromIndex:1];
        x->myStringNumber= [x->myStringNumber substringFromIndex:1];
        
        final= [self add:x];
        final->myStringNumber= [self insertNegativeSign:final->myStringNumber];
        
    }
    
    // CASE 2: If the number you are subtracting from
    //is less than the number you are subtracting.
    
    else if ([self isLessThan:x]){
        
        final=[x subtract:self];
        final->myStringNumber= [self insertNegativeSign:final->myStringNumber ];
    }
    
    //CASE 3:
    //If the number you are subtracting from is larger
    
    else{
        
        [self padthis:self toThis:x];
        
        //Looping through the two strings of MPIntegers
        //and subtractng each corresponding numbers
        firstNumLen=[myStringNumber length];
        
        for (i=firstNumLen; i>0; i--) {
            firstNum = [myStringNumber characterAtIndex:i-1]-'0';
            secondNum=[x->myStringNumber characterAtIndex:i-1]-'0';
            
            if(!(isdigit(firstNum) && isdigit(secondNum))){
                firstNum=firstNum-borrow;
                if (firstNum<secondNum) {
                    firstNum=firstNum+10;
                    result=firstNum-secondNum;
                    borrow=1;
                }
                else if(firstNum==secondNum){
                    result=firstNum-secondNum;
                    borrow=0;
                }
                else{
                    result=firstNum-secondNum;
                    borrow=0;
                }
            }
            else {
                if ([self isNegative:self]) {
                    result=firstNum;
                }
                else {
                    result=secondNum;
                }
            }
            
            NSString *stringResult=[NSString stringWithFormat:@"%i",result];
            
            [finalString insertString:stringResult atIndex:0];
            
        }
        
        
        final= [[MPInteger alloc] initWithString:finalString];
        
        final->myStringNumber= [self removeLeadingZeros:final->myStringNumber];
    }
    
    return final;
}


//Method that claculates the product
//Of two MPIntegers

-(MPInteger *) multiply:(MPInteger *)x
{
    int firstNum;
    int secNum;
    int carry;
    int product;
    MPInteger *sum;
    
    NSInteger firstLen=[myStringNumber length];
    NSInteger secLen=[x->myStringNumber length];
    
    
    if ([self isNegative:self] || [self isNegative:x]) {
        if ([self isNegative:self] && ![self isNegative:x]) {
            myStringNumber = [myStringNumber substringFromIndex:1];
            sum=[self multiply:x];
            sum->myStringNumber=[self insertNegativeSign:sum->myStringNumber];
        }
        else if([self isNegative:x] && ![self isNegative:self]){
            x->myStringNumber = [x->myStringNumber substringFromIndex:1];
            sum=[self multiply:x];
            sum->myStringNumber=[self insertNegativeSign:sum->myStringNumber];
        }
        else{
            myStringNumber = [myStringNumber substringFromIndex:1];
            x->myStringNumber = [x->myStringNumber substringFromIndex:1];
            sum=[self multiply:x];
        }
    }
    
    else{
        
        [self padthis:self toThis:x];
        
        //Updating
        secLen= [x->myStringNumber length];
        firstLen=[myStringNumber length];
        for (NSInteger i=secLen; i>0; i--) {   //For the MPInteger x
            
            carry=0;
            secNum= [x->myStringNumber characterAtIndex:i-1]-'0';
            NSMutableString *result= [NSMutableString string];
            
            for (NSInteger j=firstLen; j>0; j--) {
                firstNum=[myStringNumber characterAtIndex:j-1]-'0';
                product=firstNum*secNum+carry;
                
                if (j!=1){
                    
                    if (product>9 ){
                        int prod= product;
                        product=product%10;
                        carry=prod/10;
                        
                    }
                    
                    else{
                        carry=0;
                    }
                    
                }
                
                NSString *stringInt= [NSString stringWithFormat:@"%i",product];
                [result insertString:stringInt atIndex:0];
                
            }
            
            
            for (NSInteger y=i; y<secLen; y++) {
                [result appendString:@"0"];
            }
            
            if(i==secLen){
                sum= [[MPInteger alloc ]initWithString:result];
            }else{
                MPInteger *final= [[MPInteger alloc] initWithString:result];
                sum=[sum add:final];
                
            }
            sum->myStringNumber = [self removeLeadingZeros:sum->myStringNumber];
        }
        
    }
    
        return sum;
    
}

//Method that divides two MPIntegers

-(MPInteger *) divideBy:(MPInteger *)x
{
       
    int mult;
    MPInteger * final;
    NSInteger firstLen= [myStringNumber length];
    NSInteger secLen= [x->myStringNumber length];
    
    //NSRange range= NSMakeRange(0, firstNumLen);
    NSMutableString *finalString= [NSMutableString string];
    if (secLen>firstLen && ![self isNegative:x]){
        [finalString appendString:@"0"];
    }
    
    else if([self isNegative:self] || [self isNegative:x]){
        MPInteger *res=[[MPInteger alloc] initWithString:@"1"];
        
        if ([self isNegative:self] && [self isNegative:x]) {
            self->myStringNumber = [self->myStringNumber substringFromIndex:1];
            x->myStringNumber = [x->myStringNumber substringFromIndex:1];
            
            final=[self divideBy:x];
        }
        else if ([self isNegative:self]) {
            self->myStringNumber = [self->myStringNumber substringFromIndex:1];
            final= [self divideBy:x];
            final=[final add:res];
            final->myStringNumber =[self insertNegativeSign:final->myStringNumber];
            
        }
        else{
            x->myStringNumber = [x->myStringNumber substringFromIndex:1];
            final= [self divideBy:x];
            final=[final add:res];
            final->myStringNumber =[self insertNegativeSign:final->myStringNumber];
            
        }
        
        
        
    }
     
    else{
        MPInteger *dividend = [[MPInteger alloc] initWithString:[myStringNumber substringToIndex:secLen]];
        
        
        while ([dividend isLessThan:x]) {
            secLen++;
            dividend = [[MPInteger alloc] initWithString:[myStringNumber substringToIndex:secLen]];
            
        }
        while(secLen<=firstLen){
            mult=1;
            NSString *stringInt;
            
            MPInteger *result1;
            MPInteger *result=[[MPInteger alloc] initWithString:@"1"];
            while ([result isLessThan:dividend]){
                stringInt= [NSString stringWithFormat:@"%i",mult];
                MPInteger *multiplier= [[MPInteger alloc] initWithString:stringInt];
                
                if (mult==10) {
                    break;
                }
                
                result1=[x multiply: multiplier];
                if (([dividend isLessThan:result1]) && !([result1->myStringNumber isEqualToString:dividend->myStringNumber])) {
                    break;
                }
                result = [[MPInteger alloc] initWithString:result1->myStringNumber];
                mult++;
            }
            
            mult--;
            stringInt= [NSString stringWithFormat:@"%i",mult];
            
            [finalString appendString:stringInt];
            if (mult!=0){
                dividend= [dividend subtract:result];
            }
            
            NSString *drop;
            if (secLen!=firstLen){
                drop= [NSString stringWithFormat:@"%i", [myStringNumber characterAtIndex:secLen]-'0'];
                
                
                
                NSMutableString *temp= [NSMutableString stringWithString:dividend->myStringNumber];
                
                [temp appendString:drop];
                
                
                dividend->myStringNumber=temp;
                dividend->myStringNumber= [self removeLeadingZeros:dividend->myStringNumber];
            }
            
            secLen++;
            
        }
    
    }
    final= [[MPInteger alloc ] initWithString:finalString];
    return final;

    
}


//Method that calculates the modulus
//of two MPIntegers


-(MPInteger *) modulus:(MPInteger *)x
{
    MPInteger * result = [[MPInteger alloc] init];
    MPInteger *res;
    result = [self divideBy:x];
    res= [result multiply: x];
    result= [self subtract:res];
    
    result->myStringNumber= [self removeLeadingZeros:result->myStringNumber];
    x->myStringNumber = [self removeLeadingZeros:x->myStringNumber];
    return result;
}


//Method that checks of an MPInteger is
//less than a given MPInteger

-(BOOL) isLessThan:(MPInteger *)x
{
    x->myStringNumber= [self removeLeadingZeros:x->myStringNumber];
    myStringNumber= [self removeLeadingZeros:myStringNumber];
    
    NSInteger firstLen= [myStringNumber length];
    NSInteger secLen=[x-> myStringNumber length];
    NSInteger i=0;
    NSInteger firstDigit=[myStringNumber characterAtIndex:i]-'0';
    NSInteger secDigit=[x->myStringNumber characterAtIndex:i]-'0';
    
    while (firstDigit==secDigit && secLen==firstLen && i<firstLen) {
         firstDigit=[myStringNumber characterAtIndex:i]-'0';
         secDigit=[x->myStringNumber characterAtIndex:i]-'0';
        i++;
    }
    
    
    if (firstLen<secLen){
        return YES;
    }
    
    
    else if ([self isNegative:self]){
        return YES;
    }
    
    else if(firstLen==secLen && firstDigit<secDigit){
        return YES;
    }
     
    else{
        return NO;
    }

}

@end
