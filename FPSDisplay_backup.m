#import "FPSDisplay.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

UIDevice *myDevice;

@interface FPSDisplay ()

@property (strong, nonatomic) UILabel *displayLabel;
@property (strong, nonatomic) CADisplayLink *link;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSTimeInterval lastTime;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIFont *subFont;
@end
@implementation FPSDisplay
static FPSDisplay *extraInfo;
+ (instancetype)shareFPSDisplay {
    static FPSDisplay *shareDisplay;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareDisplay = [[FPSDisplay alloc] init];
    });
    
    return shareDisplay;
}




+ (void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [FPSDisplay shareFPSDisplay];//FPS



        });}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDisplayLabel];
    }
    return self;
}
- (void)initDisplayLabel {
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width /2 -150, -5, 300, 33);//
    
    self.displayLabel = [[UILabel alloc] initWithFrame: frame];
    self.displayLabel.layer.cornerRadius = 5;
    self.displayLabel.clipsToBounds = YES;
    self.displayLabel.textAlignment = NSTextAlignmentCenter;
    self.displayLabel.userInteractionEnabled = NO;
   

    _font = [UIFont fontWithName:@"Menlo" size:30];//14
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:10];//4
    } else {
        _font = [UIFont fontWithName:@"Courier" size:30];//14
        _subFont = [UIFont fontWithName:@"Courier" size:10];//4
    }

    [self initCADisplayLink];
   
    [[[[UIApplication sharedApplication]windows]firstObject]addSubview:self.displayLabel];
}

- (void)initCADisplayLink {
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)tick:(CADisplayLink *)link
{
    if(self.lastTime == 0){
        self.lastTime = link.timestamp;
        return;
    }
    self.count += 1;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if(delta >= 1.f){
        self.lastTime = link.timestamp;
        float fps = self.count / delta;
        self.count = 0;
        [self updateDisplayLabelText: fps];
    }
}

- (void)updateDisplayLabelText: (float) fps
{

myDevice = [UIDevice currentDevice];
[myDevice setBatteryMonitoringEnabled:YES];
double batLeft = (float)[myDevice batteryLevel] * 100;


    NSMutableString *mustr = [[NSMutableString alloc] init];
    [mustr appendFormat:@"%@",self.getSystemDate];
    self.displayLabel.font = [UIFont italicSystemFontOfSize:11];



NSString *WMText = [NSString stringWithFormat:@" %d FPS | %@ | Pin: %0.0f  Hello World ",(int)round(fps),mustr,batLeft]; 

  self.displayLabel.textColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];

  self.displayLabel.text = WMText;

NSUInteger characterCount = [WMText length];

CGFloat randColor = arc4random_uniform(256) / 255.0;
int charsFinished;
CGFloat extraHue;

CGFloat smoothness = 0.02;

NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.displayLabel.attributedText];

for (charsFinished = 0, extraHue = 0.0; charsFinished != characterCount; charsFinished = charsFinished + 1, extraHue = extraHue + smoothness) {
  [text addAttribute: NSForegroundColorAttributeName
    value: [UIColor colorWithHue:randColor + extraHue saturation:1.0 brightness:1.0 alpha:1.0]
    range: NSMakeRange(charsFinished, 1)];
}

[self.displayLabel setAttributedText: text];


    [[[[UIApplication sharedApplication] windows]lastObject] addSubview:self.displayLabel];

    
}

- (NSString *)getSystemDate
{

    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@" HH:mm:ss"];
    return [dateFormatter stringFromDate:currentDate];
}





@end