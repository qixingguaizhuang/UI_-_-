//
//  LTView.m
//  UI_分区练习
//
//  Created by sp on 15/12/25.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import "LTView.h"

@implementation LTView

- (instancetype)initWithFrame:(CGRect)frame{


    self = [super initWithFrame:frame];
    
    if (self) {
       
        self.lableOfLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 3, frame.size.height)];
        
        [self addSubview:self.lableOfLeft];
        
        [_lableOfLeft release];
        
        
        self.textfieldOfright= [[UITextField alloc]initWithFrame:CGRectMake(frame.size.width / 3, 0, frame.size.width * 2 / 3, frame.size.height)];
        
        self.textfieldOfright.borderStyle = 3;
        
        [self addSubview:self.textfieldOfright];
        
        
    }

    return self;

}




@end
