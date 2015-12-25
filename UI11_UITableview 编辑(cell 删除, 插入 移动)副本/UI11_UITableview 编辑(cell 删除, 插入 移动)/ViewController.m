//
//  ViewController.m
//  UI11_UITableview 编辑(cell 删除, 插入 移动)
//
//  Created by dllo on 15/12/25.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource >

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *arrDate;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self creatTableView ];
    
    [self handleDate];
    
    [self tableViewisEdit];
    
    self.navigationItem.title = @" Ending 编辑";
    //self.title = @"就是就是计算机";
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
     self.tableView.rowHeight = 50;
    
    [self.tableView release];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
  
}

#pragma mark - 让 TableView 进入到编辑状态

- (void)tableViewisEdit{
    
    /** 利用 VC 的一个封装方法,在导航栏上添加一个 BarButton    self editButtonItem == self.editButtonItem  当点击此 button 时,调用下面的 setEding: animateted 方法*/

    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    // 必须先调用父类方法

    [super setEditing:editing  animated:animated];

    /** 让 TableView  进入/退出 编辑状态 */

    [self.tableView setEditing:editing  animated:animated];

}


- (void)handleDate{

    self.arrDate = @[@"张丽", @"汪峰", @"蒋介石",@"流川风", @"张作霖"].mutableCopy;

}

#pragma mark -- 协议方法 DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return  self.arrDate.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *pool1 = @"resue1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pool1];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:pool1] autorelease];;
    }
    
    cell.textLabel.text = [self.arrDate objectAtIndex:indexPath.row];

    return cell;
}


#pragma  mark -- 编辑相关的方法

        /** 确定哪些行可以进入编辑状态 -->> UITableViewDataSource 类中的方法*/

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    

    /** 如果想控制某些行进入编辑状态,使用 indexPath 参数,判断具体的(区)行*/
    
    /** 注意:返回 YES 可以编辑, 返回 NO ,不能编辑. 默认此方法不用实现,默认是 YES ,都可以进行编辑 */
    
    
//    if (indexPath.row == 0) {
//        <#statements#>
//    }

    
    return YES;
}

        /** 提交点击状态 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
        /** 实现删除功能 */
    
    if (UITableViewCellEditingStyleDelete == editingStyle) {
       
        /** 从数据源删除数据 */
        
        [self.arrDate removeObjectAtIndex:indexPath.row];
      
        /** tableView 删除 cell */
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationRight];
   
    }else if (UITableViewCellEditingStyleInsert == editingStyle){  /**__>>> 判断是否插入状态 */
    
        /** 更新数据源 */
        
        [self.arrDate insertObject:@"习近平" atIndex:indexPath.row];
    
        /** tableView 插入 cell*/
    
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    }

}


#pragma mark -- cell  移动相关的方法.

    /**确定是否可以移动*/

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    return YES;

}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{

    /** 注意:此方法中,不写代码, cell 就可以实现移动.
     *  因此,此方法中的代码主要是更新数据.
    
     / **  找对象 */
    
    NSString *str = [[self.arrDate objectAtIndex:fromIndexPath.row] retain];

     /** 对象先从数组中移除掉 */
    
    [self.arrDate removeObjectAtIndex:fromIndexPath.row];
    
    /** 然后对象再插入数组中. */

    [self.arrDate insertObject:str atIndex:toIndexPath.row];
    
    [str release];
    
    

}



#pragma mark -- tableView Delegate

/** 确定每行的编辑风格 (删除, 添加)*/

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*需求: 第一行添加,其他行如下效果 */

    switch (indexPath.row) {
        case 0:
            return 2;/**< 插入风格 .*/
            break;
            
        case 1:
            return 1|2;/**< 选中风格 .*/
            break;
            
        case 2:
            return 1|2;
            break;
            
        default:
            return 1;/**< 删除风格 .*/
            break;
    }
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

 NSLog(@"ddd %ld, %ld", indexPath.section, indexPath.row);


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
