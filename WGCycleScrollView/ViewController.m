//
//  ViewController.m
//  WGCycleScrollView
//
//  Created by weige on 16/11/22.
//  Copyright © 2016年 Wei. All rights reserved.
//

#import "ViewController.h"
#import "WGCycleScrollView.h"

@interface ViewController ()<WGCycleScrollViewDelegate>{
    WGCycleScrollView *_headView;
    NSMutableArray *_imageArray;
    NSMutableArray *_titleArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    
    [self WGinitcycle];
    [self WGGetImage];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)WGGetImage{

    //网络上异步获取6张图片和标题
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    
    NSString *url = [NSString stringWithFormat:@"http://www.douyutv.com/api/v1/slide/6?aid=ios&auth=97d9e4d3e9dfab80321d11df5777a107&client_sys=ios&time=%@",timeString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers error:nil];
        NSArray *topDataArray = [dict objectForKey:@"data"];
        for (NSDictionary *topdata in topDataArray) {
            
            [_imageArray addObject:[topdata objectForKey:@"pic_url"]];
            
            [_titleArray addObject:[topdata objectForKey:@"title"]];
        }
        _headView.imageURLStringsGroup=_imageArray;
        _headView.titlesGroup=_titleArray;
    }];
    
    [postDataTask resume];
}

-(void)WGinitcycle{
    //添加循环控件
    _headView=[WGCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) imagesGroup:_imageArray];
    _headView.titlesGroup=_titleArray;
    _headView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _headView.delegate=self;
    _headView.pageControlStyle=WGCycleScrollViewPageContolStyleClassic;
    _headView.pageControlAliment = WGCycleScrollViewPageContolAlimentRight;
    _headView.titleLabelTextFont=[UIFont systemFontOfSize:17];
    [self.view addSubview:_headView];
}

-(void)cycleScrollView:(WGCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击第%li张",(long)index);
}

@end
