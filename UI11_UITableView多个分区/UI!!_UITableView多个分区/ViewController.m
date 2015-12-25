//
//  ViewController.m
//  UI!!_UITableView多个分区
//
//  Created by dllo on 15/12/25.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableDictionary *dicContact;

@property (nonatomic, retain) NSMutableArray *arrKey;

@end


@implementation ViewController


- (void)dealloc{
    
    [_tableView release];
    [_dicContact release];
    [_arrKey release];
    [super dealloc];

}

- (void)viewDidLoad {
  
    [super viewDidLoad];
    [self creatTableView];
    [self handleDate];
    
  // [self handleDateFromPlist];
 
    }


/* 创建 tableView */

- (void)creatTableView{

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    [_tableView release];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;

}


#pragma mark - UITableViewDataSource 代理方法

/**cell 赋值  重用池 ,必须实现的两个方法 (1/2) */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *poll1 = @"reuse1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:poll1];
    
    if (cell ==  nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:poll1] autorelease];
    }
    
    /** cell 的赋值 */
    /** 先确定分区-->> */
    
    /**通过分区找到存在的 key 值*/
    
    NSString *key = [self.arrKey objectAtIndex:indexPath.section];
    
    /** 通过字典中的 key 值找到字典中的联系人数组信息*/
    
    NSArray *arr = [self.dicContact objectForKey:key];
    
    
    /**...................................................**/
    
    /** 每个联系人的小字典.*/
    
    /** 根据每个分区, 找到分区中的行数,通过行数找到数组中联系人的小字典*/
    
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    
    /** 通过小字典中的 name key 值找到 名字信息 */
    
    cell.textLabel.text = [dic objectForKey:@"name"];

    return cell;

}

/** 分区数 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrKey.count;
    
}

/** 分区的区头标题  x, y ,z */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.arrKey objectAtIndex:section];
    
}

/** 每个分区数的行数 必须实现的两个方法( 2/2 )*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    /** 通过区找到数组中的 key 值 .*/
    
    NSString *key = [self.arrKey objectAtIndex:section];
    
    /** 根据 key 从字典中获取数组 */
    
    NSArray *arr = [self.dicContact objectForKey:key];
    
    /** 返回 arr 个数*/
    
    return  arr.count;
    
}

/** 右侧索引部分. --->>> dateSource 方法 */
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
 
    return self.arrKey;
    
}

/* 数据写入 */

- (void)handleDate{
    
    
    self.dicContact = @{@"z":@[@{@"name":@"zhangsan",@"phone":@"12345"},
                               @{@"name":@"zhaosi",@"phone":@"45678"},
                               @{@"name":@"zhaopeng", @"phone":@"78978"}],
                        
                        @"L":@[@{@"name":@"lidan",@"phone":@"982554"}],
                        
                        @"Y":@[@{@"name":@"yangyang",@"phone":@"978675"},
                               @{@"name":@"yangxing",@"phone":@"788767"}],
                        
                        }.mutableCopy;
    
    
    /** 将字典中的所有 key 取出来 ,并且排序 sorted 排序 */
    
    /** self.arrKey =  [[self.dicContact  allKeys] sortedArrayUsingSelector:@selector(compare:)].mutableCopy; */
    
    /**取出所有字典中的 key 值*/
    
    self.arrKey = [NSMutableArray arrayWithArray:[self.dicContact  allKeys]];
    
    /* 正序排序 compare */
    
    [self.arrKey sortUsingSelector:@selector(compare:)];
    
}

/** plist 文件 */

-(void)handleDateFromPlist{
    
    
    /** 创建 plist 文件*/
    
    /** 将 plist 文件转换成字典 */
    
    /** 首先找回 plist 文件的路径  NSBundle 左边面板的包*/
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    
    /** 生成字典. */
    
    self.dicContact = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    self.arrKey = [self.dicContact allKeys].mutableCopy;
    
    NSLog(@"%@", self.dicContact);
    
}



#pragma mark UITableViewDataDelegate 代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSLog( @"ddd, %ld, %ld", indexPath.section, indexPath.row);
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
