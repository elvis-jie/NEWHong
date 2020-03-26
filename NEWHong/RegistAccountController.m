//
//  RegistAccountController.m
//  NEWHong
//
//  Created by 尚广杰 on 2020/3/25.
//  Copyright © 2020 尚广杰. All rights reserved.
//

#import "RegistAccountController.h"
#import "AppDelegate.h"
#import "CustomCameraViewController.h"
@interface RegistAccountController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView* tableV;
@property(nonatomic,strong)UITextField* nameTextField;
@property(nonatomic,strong)UITextField* cardTextField;
@property(nonatomic,strong)UITextField* teleTextField;
@property(nonatomic,strong)UILabel* remindLab;           //红字提醒
@property(nonatomic,strong)UITextField* pwTextField;
@property(nonatomic,strong)UIButton* showBtn;            //展示密码
@property(nonatomic,strong)UITextField* surePwTextField;
@property(nonatomic,strong)UIButton* registBtn;          //注册按钮
@property(nonatomic,strong)UITextView* textView;         //用户协议
@end

@implementation RegistAccountController
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
    self.title = @"注册账号";
     [self tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else
    {
        return 2;
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
                cell.imageView.image = [UIImage imageNamed:@"Cardbag"];
                cell.textLabel.text = @"居民身份证";
                
            }
                
                break;
            case 1:
            {
                cell.imageView.image = [UIImage imageNamed:@"use"];
                if (!self.nameTextField) {
                    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, mDeviceWidth - 90, 50)];
                    self.nameTextField.placeholder = @"姓名";
                    self.nameTextField.font = [UIFont systemFontOfSize:15.0];
                    self.nameTextField.delegate = self;
                    [cell addSubview:self.nameTextField];
                }
            }
                break;
            case 2:
            {
                cell.imageView.image = [UIImage imageNamed:@"ID"];
                if (!self.cardTextField) {
                    self.cardTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, mDeviceWidth - 90, 50)];
                    self.cardTextField.placeholder = @"居民身份证号码";
                    self.cardTextField.font = [UIFont systemFontOfSize:15.0];
                    self.cardTextField.delegate = self;
                    [cell addSubview:self.cardTextField];
                }
            }
                break;
            
            default:
                break;
        }
    }else if(indexPath.section==1){
        switch (indexPath.row) {
            case 0:
            {
                cell.imageView.image = [UIImage imageNamed:@"phone"];
                if (!self.teleTextField) {
                    self.teleTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, mDeviceWidth - 90, 50)];
                    self.teleTextField.placeholder = @"手机号";
                    self.teleTextField.font = [UIFont systemFontOfSize:15.0];
                    self.teleTextField.delegate = self;
                    [cell addSubview:self.teleTextField];
                }
            
            }
                break;
            case 1:
            {
                if (!self.remindLab) {
                    self.remindLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, mDeviceWidth - 30, 40)];
                    self.remindLab.text = @"手机号码真实性会影响企业登记注册业务,请确保真实可用！";
                    self.remindLab.font = [UIFont systemFontOfSize:15.0];
                    self.remindLab.adjustsFontSizeToFitWidth = YES;
                    self.remindLab.textAlignment = NSTextAlignmentLeft;
                    self.remindLab.textColor = [UIColor redColor];
                    
                    [cell addSubview:self.remindLab];
                }
            }
                break;
       
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                cell.imageView.image = [UIImage imageNamed:@"lock"];
                if (!self.pwTextField) {
                    self.pwTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, mDeviceWidth - 110, 50)];
                    self.pwTextField.placeholder = @"8-16位数字/大小写字母/符号三种以上";
                    self.pwTextField.font = [UIFont systemFontOfSize:15.0];
                    self.pwTextField.secureTextEntry = YES;
                    self.pwTextField.delegate = self;
                    [cell addSubview:self.pwTextField];
                }
           
                if (!self.showBtn) {
                    self.showBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth - 30, 15, 20, 20)];
                    [self.showBtn setBackgroundColor:[UIColor redColor]];
                    [self.showBtn addTarget:self action:@selector(showBtn:) forControlEvents:UIControlEventTouchUpInside];
                    self.showBtn.selected = YES;
                    [cell addSubview:self.showBtn];
                }
            }
                break;
            case 1:
            {
                cell.imageView.image = [UIImage imageNamed:@"lock2"];
       
                if (!self.surePwTextField) {
                    self.surePwTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, mDeviceWidth - 110, 50)];
                    self.surePwTextField.placeholder = @"确认密码";
                    self.surePwTextField.font = [UIFont systemFontOfSize:15.0];
                    self.surePwTextField.delegate = self;
                    [cell addSubview:self.surePwTextField];
                }
            }
                break;
                
                
            default:
                break;
        }
    }

    


    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else if (section==1){
        return 10;
    }
    else{
        return 150;
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        UIView* whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mDeviceWidth, 80)];
        [whiteView setBackgroundColor:[UIColor clearColor]];
        
        //协议
        
        NSString* str = @"注册即视为同意《用户协议》";
        NSString *str1 = @"注册即视为同意";
        
        NSString *str2 = @"《用户协议》";
        NSRange range2 = [str rangeOfString:str2];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(mDeviceWidth - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 10, rect.size.width + 20, rect.size.height + 10)];
        _textView.font = [UIFont systemFontOfSize:15.0];
        _textView.delegate = self;
        _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘_textView.scrollEnabled = NO;
        [_textView setBackgroundColor:[UIColor clearColor]];
        _textView.textColor = [UIColor blackColor];
        
        
          NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
        
        [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range2];
        
         NSString *valueString2 = [[NSString stringWithFormat:@"yonghuxieyi://%@",str2] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [mastring addAttribute:NSLinkAttributeName value:valueString2 range:range2];
        
         _textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
        _textView.attributedText = mastring;
        
        
        
        [whiteView addSubview:_textView];
        
        
        self.registBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth/4, CGRectGetMaxY(_textView.frame) + 20, mDeviceWidth/2, 40)];
        [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [self.registBtn setBackgroundColor:[UIColor redColor]];
        self.registBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.registBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self.registBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.registBtn.layer.cornerRadius = 20;
        self.registBtn.layer.masksToBounds = YES;
        [whiteView addSubview:self.registBtn];
        
        return whiteView;
    }
    return nil;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
        if ([[URL scheme] isEqualToString:@"yonghuxieyi"]) {
        
        NSLog(@"点击了用户协议");
        
                return NO;
        
            }
    
        return YES;
    
}
#pragma mark -- 注册
-(void)registBtn:(UIButton*)sender{
    //跳转拍照
    CustomCameraViewController *controller = [[CustomCameraViewController alloc] init];
    [controller setBlockGetPicture:^(UIImage *image){
        NSLog(@"回调后宽高==%f==%f",image.size.width,image.size.height);

    }];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark -- 显示密码
-(void)showBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.pwTextField.secureTextEntry = YES;
        [self.showBtn setBackgroundColor:[UIColor redColor]];
    }else{
        self.pwTextField.secureTextEntry = NO;
        [self.showBtn setBackgroundColor:[UIColor greenColor]];
    }
}
@end
