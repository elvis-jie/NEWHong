//
//  NewLoginViewController.m
//  NEWHong
//
//  Created by 尚广杰 on 2020/3/26.
//  Copyright © 2020 尚广杰. All rights reserved.
//

#import "NewLoginViewController.h"
#import "ViewController.h"
@interface NewLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView* userImage;
@property(nonatomic,strong)UITextField* cardTextField;
@property(nonatomic,strong)UILabel* line1;


@property(nonatomic,strong)UIImageView* closeImage;
@property(nonatomic,strong)UITextField* pwTextField;
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UIButton* showBtn;         //显示密码

@property(nonatomic,strong)UIButton* needKonwBtn;     //系统使用须知
@property(nonatomic,strong)UIButton* loginBtn;        //登录
@property(nonatomic,strong)UIButton* registBtn;       //注册
@property(nonatomic,strong)UIButton* forgetBtn;       //忘记密码
@property(nonatomic,strong)UIButton* sureNameBtn;     //姓名变更重新实名验证

@property(nonatomic,strong)UILabel* centerLine;       //中间竖线

@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* otherLabel;       //其它登录方式

@property(nonatomic,strong)UIButton* faceBtn;         //人脸按钮
@property(nonatomic,strong)UILabel* facaLabel;        //人脸


@end

@implementation NewLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登记注册";
    
    [self setUI];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    ViewController* VC = [[ViewController alloc]init];
//    [self.navigationController pushViewController:VC animated:YES];
//}
#pragma mark -- UI
-(void)setUI{
    self.userImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, kNavBarHeight + 30, 20, 20)];
    self.userImage.image = [UIImage imageNamed:@"use"];
    [self.view addSubview:self.userImage];
    
    self.cardTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImage.frame) + 15, self.userImage.frame.origin.y, mDeviceWidth - 90, 20)];
    self.cardTextField.placeholder = @"请输入证件号码";
    self.cardTextField.font = [UIFont systemFontOfSize:13.0];
    self.cardTextField.delegate = self;
    self.cardTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.cardTextField];
    

    
    
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.userImage.frame) + 10, mDeviceWidth - 60, 1)];
    [self.line1 setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:self.line1];
    
    //
    self.closeImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.line1.frame) + 30, 20, 20)];
    self.closeImage.image = [UIImage imageNamed:@"lock"];
    [self.view addSubview:self.closeImage];
    
    self.pwTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.closeImage.frame) + 15, self.closeImage.frame.origin.y, mDeviceWidth - 90, 20)];
    self.pwTextField.placeholder = @"请输入密码";
    self.pwTextField.font = [UIFont systemFontOfSize:13.0];
    self.pwTextField.delegate = self;
    self.pwTextField.secureTextEntry = YES;
    self.pwTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.pwTextField];
    
    self.showBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth - 50, self.closeImage.frame.origin.y, 20, 20)];
    [self.showBtn setBackgroundColor:[UIColor redColor]];
    [self.showBtn addTarget:self action:@selector(showBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.showBtn.selected = YES;
    [self.view addSubview:self.showBtn];
    
    
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.closeImage.frame) + 10, mDeviceWidth - 60, 1)];
    [self.line2 setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:self.line2];
    
    
    self.needKonwBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.line2.frame) + 5, 180, 20)];
    [self.needKonwBtn setTitle:@"【阅读：系统使用须知】" forState:UIControlStateNormal];
    self.needKonwBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.needKonwBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.needKonwBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.needKonwBtn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.needKonwBtn];
    
    
    //登录
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth/4, CGRectGetMaxY(self.needKonwBtn.frame) + 40, mDeviceWidth/2, 40)];
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn setBackgroundColor:[UIColor redColor]];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
    self.registBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth/4, CGRectGetMaxY(self.loginBtn.frame) + 5, mDeviceWidth/4 - 0.5, 20)];
    [self.registBtn setTitle:@"新用户注册>" forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.registBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.registBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
    
    self.centerLine = [[UILabel alloc]initWithFrame:CGRectMake(mDeviceWidth/2 - 0.1, self.registBtn.frame.origin.y, 1, 20)];
    [self.centerLine setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.centerLine];
    
    self.forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth/2 + 0.5, CGRectGetMaxY(self.loginBtn.frame) + 5, mDeviceWidth/4 - 0.5, 20)];
    [self.forgetBtn setTitle:@"忘记密码>" forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:self.forgetBtn];
    
    
    self.sureNameBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth/4, CGRectGetMaxY(self.forgetBtn.frame) + 5, mDeviceWidth/2, 20)];
    [self.sureNameBtn setTitle:@"姓名变更后重新实名验证>" forState:UIControlStateNormal];
    self.sureNameBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.sureNameBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.sureNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.sureNameBtn];
    
    
    
    
    //其它登录方式
    self.otherLabel = [[UILabel alloc]init];
    self.otherLabel.text = @"其它登录方式";
    self.otherLabel.font = [UIFont systemFontOfSize:13.0];
    CGRect rect = [self.otherLabel.text boundingRectWithSize:CGSizeMake(mDeviceWidth - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    
    self.otherLabel.frame = CGRectMake(mDeviceWidth/2 - rect.size.width/2, mDeviceHeight - KSAFEBAR_HEIGHT - 120, rect.size.width, rect.size.height);
    [self.view addSubview:self.otherLabel];
    
    self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(self.otherLabel.frame.origin.x - 60, CGRectGetMaxY(self.otherLabel.frame) - rect.size.height/2, 50, 1)];
    [self.line3 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.line3];
    self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.otherLabel.frame) + 10, CGRectGetMaxY(self.otherLabel.frame) - rect.size.height/2, 50, 1)];
    [self.line4 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.line4];
    
    
    self.faceBtn = [[UIButton alloc]initWithFrame:CGRectMake(mDeviceWidth/2 - 25, CGRectGetMaxY(self.otherLabel.frame) + 20, 50, 50)];
    [self.faceBtn setImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
    self.faceBtn.layer.cornerRadius = 25;
    self.faceBtn.layer.masksToBounds = YES;
    self.faceBtn.layer.borderWidth = 1;
    self.faceBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:self.faceBtn];
    
    
    self.facaLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.faceBtn.frame.origin.x, CGRectGetMaxY(self.faceBtn.frame) + 5, 50, 20)];
    self.facaLabel.text = @"人脸";
    self.facaLabel.font = [UIFont systemFontOfSize:13.0];
    self.facaLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.facaLabel];
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

#pragma mark -- 注册
-(void)registBtn:(UIButton*)sender{
    ViewController* VC = [[ViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}
@end
