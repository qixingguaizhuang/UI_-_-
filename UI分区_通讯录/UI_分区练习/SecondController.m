//
//  SecondController.m
//  UI_分区练习
//
//  Created by dllo on 15/12/25.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import "SecondController.h"
#import "LTView.h"



@interface SecondController ()

@property(nonatomic, retain) UITextField *textFieldName;

@property (nonatomic, retain) UITextField *textFieldOfPhoneNumber;

@property (nonatomic, retain) UIImageView *imageViewOfHead;

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
//    [self creatTextFieldName];
    [self creatNameAndNumaber];
   
}



- (void)creatTextFieldName{

    self.textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(40, 120, self.view.frame.size.width - 80, 60)];
    
    self.textFieldName.borderStyle = 3;
    
    self.textFieldName.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textFieldName];
    
    [_textFieldName release];

}


- (void)creatNameAndNumaber{


    LTView *nameView = [[LTView alloc] initWithFrame:CGRectMake(40, 220, self.view.frame.size.width - 80, 60)];
    
    nameView.lableOfLeft.text = @"姓名";
    
    nameView.textfieldOfright.placeholder = @"";
    
    [self.view addSubview:nameView];


    [nameView release];
    
    
    
    LTView *viewOfKey = [[LTView alloc] initWithFrame:CGRectMake(40, 270, self.view.frame.size.width - 80, 60)];
    
    viewOfKey.lableOfLeft.text = @"电话号码";
    
    viewOfKey.textfieldOfright.placeholder = @"";
    
    [self.view addSubview:viewOfKey];
    
    [viewOfKey release];
    
    


}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
