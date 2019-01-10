//
//  ViewController.m
//  ZSPopViewSet-master
//
//  Created by safiri on 2018/7/10.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ViewController.h"
#import "ZSPopCustomView.h"
#import "PopInfoTextView.h"
#import "PopInfoImageView.h"
#import "PopInfoInputView.h"
#import "PopFSCalendarView.h"

@interface ViewController ()<PopShowImageViewDelegate, PopInfoInputViewDelegate,PopFSCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pandaImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pandaImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapPanda = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPandaImageView)];
    [self.pandaImageView addGestureRecognizer:tapPanda];
}
- (IBAction)PopContentLabelClick:(id)sender {
    PopInfoTextView *popLabelView = [[PopInfoTextView alloc] initWithSize:CGSizeMake(200, 100) andContent:@"Do any additional setup after loading the view, typically from a nib."];
    //popLabelView.contentLabel....
    popLabelView.contentEdge = UIEdgeInsetsMake(10, 10, 10, 10);
    [popLabelView showInView:self.view centerAtPoint:self.view.center duration:0.5f completion:^{
        NSLog(@"popLabelView show complete");
    }];
}
- (IBAction)popContentLabelWithArrowClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Do any additional setup after loading the view, typically from a nib.";
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    
    
    ZSPopCustomView *popCustomView = [[ZSPopCustomView alloc] initWithSize:CGSizeMake(200, 100)];
    popCustomView.showArrow = YES;
    popCustomView.bgShadowType = ShadowTypeGray;
    popCustomView.customView = label;
    [popCustomView showCustomViewInView:self.view fromRect:button.frame completion:^{
        NSLog(@"popContentLabelWithArrow show complete");
    }];
}

- (IBAction)popShowImageClick:(id)sender {
    UIImage *image = [UIImage imageNamed:@"panda"];
    PopInfoImageView *popImageView = [[PopInfoImageView alloc] initWithSize:CGSizeMake(100, 100) andShowImage:image];
    popImageView.bgShadowType = ShadowTypeGray;
    popImageView.canLongPressGesture = YES;
    popImageView.showImageViewDelegate = self;
    [popImageView showInView:self.view centerAtPoint:self.view.center duration:0.5f completion:^{
        NSLog(@"popImageView show complete");
    }];
}
- (void)tapPandaImageView {
    UIImage *image = [UIImage imageNamed:@"panda"];
    PopInfoImageView *popImageView = [[PopInfoImageView alloc] initWithSize:CGSizeMake(100, 100) andShowImage:image];
    popImageView.bgShadowType = ShadowTypeEffect;
    popImageView.canLongPressGesture = YES;
    popImageView.showImageViewDelegate = self;
    popImageView.originFrame = self.pandaImageView.frame;
    popImageView.isCloseImageViewToOriginFrame = YES;
    [popImageView showInView:self.view centerAtPoint:self.view.center duration:0.5f completion:^{
        NSLog(@"popImageView show complete");
    }];
}
- (void)longPressGestureBegan {
    NSLog(@"longPressGestureBegan");
}

- (IBAction)PopInfoInputClick:(id)sender {
    PopInfoInputView *popInputView = [[PopInfoInputView alloc] initWithSize:CGSizeMake(260, 160) title:@"姓名" placeholderString:@"请输入姓名"];
    popInputView.infoInputViewDelegate = self;
    popInputView.backgroundColor = [UIColor brownColor];
    [popInputView showInView:self.view centerAtPoint:self.view.center duration:0.5f completion:^{
        NSLog(@"PopInfoInputView show complete");
    }];
}
- (void)popInfoInputViewConfirmWithContent:(NSString *)contentString {
    NSLog(@"popInfoInputViewConfirmWithContent: %@",contentString);
}
- (void)popInfoInputViewCancel {
    NSLog(@"popInfoInputViewCancel");
}
- (IBAction)PopCalendarButtonClick:(id)sender {
    CGFloat width = self.view.frame.size.width * 0.9;
    PopFSCalendarView *popCalendarView = [[PopFSCalendarView alloc] initWithSize:CGSizeMake(width, width)];
    popCalendarView.bgShadowType = ShadowTypeEffect;
    popCalendarView.popCalendarDelegate = self;
    [popCalendarView.confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [popCalendarView.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [popCalendarView showInView:self.view centerAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-20) duration:0.5f completion:^{
        NSLog(@"PopFSCalendarView show complete");
    }];
}

- (void)confirmCanlendarSelectDate:(NSDate *)selectDate {
    NSLog(@"selectDate = %@",selectDate.description);
}

- (IBAction)popBottomFlowupClick:(id)sender {
    
    ZSPopBaseView *popFlowupView = [[ZSPopBaseView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    popFlowupView.backgroundColor = [UIColor brownColor];
    popFlowupView.showAnimationType = ShowTypeBottomFlowup;
    [popFlowupView showInView:self.view duration:0.5f completion:^{
        NSLog(@"popFlowupView show complete");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [popFlowupView adjustFrame:CGRectMake(0, 200, self.view.frame.size.width, 200) animation:YES duration:0.5f completion:^{
                NSLog(@"popFlowupView adjust complete");
            }];
        });
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
