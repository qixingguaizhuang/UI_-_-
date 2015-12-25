//
//  ViewController.m
//  UI10_UITableView
//
//  Created by dllo on 15/12/24.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> // 系统自己的代理,已经完成三步 直接写后三步

@property (nonatomic, retain) UITableView *tableView;

/** 声明一个数组属性,用于存放数据 (系统提供的 cell 有三个控件) */

@property (nonatomic, retain) NSMutableArray *arrDate;

@end

@implementation ViewController

- (void)dealloc{
    
    [_arrDate release];
    
    [_tableView release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
 
    [self creatTableView];
    
    [self handleDate];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)handleDate{
    
    /** 数组中都是字符串对象 */
    
//    self.arrDate = @[@"娜美",@"罗宾",@"香吉士",@"索隆",@"汉库克",@"布鲁克",@"佩罗娜",@"香阁斯",@"艾斯",@"小丑巴基",@"桔梗",@"莫利亚",@"乔巴",@"弗兰克"].mutableCopy;
    
    /** 数组中都是字典对象 字面量方法左边是 key */
    
    self.arrDate = @[
                     @{@"title":@"zhang",
                       @"detial":@"aaa",
                       @"image":@"f3"},
                     
                     @{@"title":@"zhang2",
                       @"detial":@"bbb",
                       @"image":@"f1.jpg"},
                     
                     @{@"title":@"zhang3",
                       @"detial":@"ccc",
                       @"image":@"b1.jpg"},
                     
                     @{@"title":@"zhang4",
                       @"detial":@"ddd",
                       @"image":@"zhanghu"},
                     
                     @{@"title":@"zhang5",
                       @"detial":@"eee",
                       @"image":@"f2.jpg"},
                     
                     ].mutableCopy;

}


#pragma mark - 知识点 1 :UITableView




- (void)creatTableView{
    
    /*
     *创建对象
     *参数 2 . 指定风格,有两种风格( 普通, 分组 )
     */

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
    
    [_tableView release];
    
    
    /** tableView 的一些 API */
    
    
    /** 全局 cell 的高度 (对所有 cell 起作用)*/
    
    self.tableView.rowHeight = 100;
    
    /** 分割线样式 */
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    /** 分割线颜色 */
    
    self.tableView.separatorColor = [UIColor redColor];

    /* !!! 重点: tableView 大部分的功能是通过 Delegate 设计模式实现的,即代理人通知 tableView 如何做...,这里代理人是 VC  */
    
    self.tableView.dataSource = self; // dataSource 主要是数据的传递
    
    self.tableView.delegate = self;
    
}



#pragma mark - tableView DateSource

/** 必须实现两个协议方法, 第一种方法 (1/2) 告知 tableView 要有几个行数 row */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrDate.count;

}


#pragma mark - 知识点 2 UITableViewCell 重用池机制

/** 必须实现的协议方法 第二种方法  设置你的 TableView 中每一行 (cell) 显示的内容和格式(2/2)*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"%ld,%ld ", indexPath.section, indexPath.row);
    
    /* UITableViewCellStyleDefault | TableView 默认类型*/
    
    /** 防止写错池子,字符串定义一个池子 < static NSString *pool1 = @"reuse" > static 在静态区开辟空间,程序结束,内存才释放.
     
     * static 修饰的变量,只初始化一次.
     
     */
    
    static NSString *pool1 = @"reuse1";
    
    /** 指针指向一个池子,不是对象 */
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pool1];
    
    /** 如果池子为空 重新建一个 */
    
    if (cell ==  nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pool1] autorelease];
    }
    
    
    /**   
     * cell 进行赋值
     
     * 系统封装好的 cell 只有三个控件可以赋值 --->> API ( textLabel,detailTextLabel,imageView);
     
     * 系统的 cell 有所谓的四种风格 (style) 本质是上面三个控件不同组合的风格.
     
     */
    
    
 //   cell.textLabel.text = [self.arrDate  objectAtIndex:indexPath.row];
    
    
    /** 先取出数组中相应的字典键值对 */
    
    NSDictionary *dic = [self.arrDate objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic objectForKey:@"title"];
    
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
    
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    
    
    /** cell 最后面的辅助区域 箭头样式*/
 
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    /** 如果不为空, 直接返回 cell 出去 */
    
    return cell;

}




#pragma mark - tableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSLog( @"ddd, %ld, %ld", indexPath.section, indexPath.row);

}


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
