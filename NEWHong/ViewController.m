//
//  ViewController.m
//  NEWHong
//
//  Created by 尚广杰 on 2020/3/25.
//  Copyright © 2020 尚广杰. All rights reserved.
//

#import "ViewController.h"
#import "RegistAccountController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableV;
@property(nonatomic,strong)NSArray* defaultList;   // 列表前边默认数据
@property(nonatomic,strong)UISwitch* switchBtn;    //开关
@end

@implementation ViewController
-(UITableView *)tableView{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, mDeviceWidth, mDeviceHeight - KSAFEBAR_HEIGHT - kNavBarHeight) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        
        if (@available(iOS 11.0, *)) {
            _tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.separatorInset = UIEdgeInsetsZero;
        [self.view addSubview:self.tableV];
    }
    return _tableV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号管理";
    self.defaultList = @[@[@{@"title":@"证件类型",@"image":@"ptoto"},@{@"title":@"用户名",@"image":@"ptoto"},@{@"title":@"姓名",@"image":@"ptoto"},@{@"title":@"证件号码",@"image":@"ptoto"},@{@"title":@"手机号",@"image":@"ptoto"},@{@"title":@"实名等级",@"image":@"ptoto"}],@[@{@"title":@"是否办理企业等级注册",@"image":@"ptoto"},@{@"title":@"办理企业等级注册截止日期",@"image":@"ptoto"},@{@"title":@"修改密码",@"image":@"ptoto"}]];
    [self tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.defaultList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 6;
    }else
    {
        return 3;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.detailTextLabel.text = @"居民身份证";
                
            }
                
                break;
            case 1:
            {
                cell.detailTextLabel.text = @"***********3212";
                cell.detailTextLabel.textColor = [UIColor redColor];
            }
                break;
            case 2:
            {
                cell.detailTextLabel.text = @"**远";
            }
                break;
            case 3:
            {
                cell.detailTextLabel.text = @"***********3212";
            }
                break;
            case 4:
            {
                cell.detailTextLabel.text = @"131****7134";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 5:
            {
                cell.detailTextLabel.text = @"四级";
            }
                break;
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                if (!self.switchBtn) {
                    self.switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(mDeviceWidth - 70, 10, 50, 30)];
                    self.switchBtn.on = YES;
                    [self.switchBtn setOnTintColor: [UIColor orangeColor]];
                    [cell addSubview:self.switchBtn];
                }
                cell.textLabel.textColor = [UIColor redColor];
            }
                break;
            case 1:
            {
                cell.detailTextLabel.text = @"2020-03-27";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 2:
            {
              
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
           
            default:
                break;
        }
    }
    
    NSDictionary* dic = self.defaultList[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"photo"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 80;
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {
        UIView* whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mDeviceWidth, 80)];
        [whiteView setBackgroundColor:[UIColor clearColor]];
        
        UIButton* logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, mDeviceWidth, 50)];
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn setBackgroundColor:[UIColor whiteColor]];
        logoutBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [logoutBtn addTarget:self action:@selector(logoutBtn:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:logoutBtn];
        
        return whiteView;
    }
    return nil;
}

-(void)logoutBtn:(UIButton*)sender{
    RegistAccountController* registVC = [[RegistAccountController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
@end
