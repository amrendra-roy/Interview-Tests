//
//  ViewController.m
//  PhotoGallery
//
//  Created by Sachin Patil on 24/08/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import "ViewController.h"
#import "HttpRequest.h"

#import "DataModel.h"
#import "CustomCollectionView.h"
typedef enum
{
    Animals = 0,
    Birds,
    Flags,
    Flowers,
    Fruits,
    Technology,
    Vegetables
    
}CategoryType;
@interface ViewController ()<HttpConnectionDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    __weak IBOutlet UITableView *tblview;
    __weak IBOutlet UIImageView *preViewImage;
    
    NSMutableArray *_arrOfImages;
    
    NSMutableArray *arOfAnimals;
    NSMutableArray *arOfBirds;
    NSMutableArray *arOfFlags;
    NSMutableArray *arOfFlowers;
    NSMutableArray *arOfFruits;
    NSMutableArray *arOfTechnology;
    NSMutableArray *arOfVegetables;
}



@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //init array
    _arrOfImages = [[NSMutableArray alloc] init];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
     HttpRequest *connection = [[HttpRequest alloc] initWithStringURL:@"http://192.168.10.104/imageData.php" withDelegate:self];
    NSLog(@"connection has created = %@",connection);
};
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;//_arrOfImages.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = nil;
    switch (section) {
        case Animals:
            str = @"Animals";
            break;
            
        case Birds:
            str = @"Birds";
            break;
        case Flags:
            str = @"Flags";
            break;
        case Flowers:
            str = @"Flowers";
            break;
        case Fruits:
            str = @"Fruits";
            break;
        case Technology:
            str = @"Technology";
            break;
        case Vegetables:
            str = @"Vegetables";
            break;
        default:
            break;
    }
    return str;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdenti:CellIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(CustomTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.tag;
    
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}
#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        switch (section) {
        case Animals:
            return arOfAnimals.count;
            break;
            
        case Birds:
            return arOfBirds.count;
            break;
        case Flags:
            return arOfFlags.count;
            break;
        case Flowers:
            return arOfFlags.count;
            break;
        case Fruits:
            return arOfFruits.count;
            break;
        case Technology:
            return arOfTechnology.count;
            break;
        case Vegetables:
            return arOfVegetables.count;
            break;
        default:
            break;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    //NSArray *collectionViewArray = self.colorArray[[(CustomCollectionView *)collectionView indexPath].row];
    switch (indexPath.section) {
        case Animals:
            
           // DataModel *model = [arOfAnimals objectAtIndex:0];
            
            break;
            
        case Birds:
            
            
            
            break;
        case Flags:
            
            
            
            break;
        case Flowers:
            
            
            
            break;
        case Fruits:
            
            
            break;
        case Technology:
            
            
            break;
        case Vegetables:
            
            
            break;
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]])
        return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    NSInteger index = collectionView.tag;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}




#pragma mark- HttpConnectionDelegate
- (void)didHttpConnectionFailWithError:(NSError*)error
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Connection is fail" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [al show];
    
}
- (void)didHttpConnectionSuccessWithData:(NSData*)data
{
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    //NSLog(@"dictionary of Data is = %@",dictionary);
    
    
     arOfAnimals = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"animals"]];
     arOfBirds = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"birds"]];
     arOfFlags = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"flags"]];
     arOfFlowers = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"flowers"]];
     arOfFruits = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"fruits"]];
     arOfTechnology = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"technology"]];
     arOfVegetables = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"vegetables"]];

    //http://192.168.10.104/images/animals/cat.png
    for (NSDictionary *dicAnimal in arOfAnimals) {
        
        DataModel *model = [[DataModel alloc] init];
        model.name = [dicAnimal objectForKey:@"name"];
        model.imgURL = [NSString stringWithFormat:@"http://192.168.10.104/%@",[dicAnimal objectForKey:@"imgURL"]];
        [_arrOfImages addObject:model];
    }
    
    
    for (NSDictionary *dicBird in arOfBirds) {
        DataModel *model = [[DataModel alloc] init];
        model.name = [dicBird objectForKey:@"name"];
        model.imgURL = [NSString stringWithFormat:@"http://192.168.10.104/%@",[dicBird objectForKey:@"imgURL"]];
        [_arrOfImages addObject:model];
        
    }
    
    for (NSDictionary *dicflag in arOfFlags) {
        DataModel *model = [[DataModel alloc] init];
        model.name = [dicflag objectForKey:@"name"];
        model.imgURL = [NSString stringWithFormat:@"http://192.168.10.104/%@",[dicflag objectForKey:@"imgURL"]];
        [_arrOfImages addObject:model];
        
    }
    
    for (NSDictionary *dicFlow in arOfFlowers) {
        DataModel *model = [[DataModel alloc] init];
        model.name = [dicFlow objectForKey:@"name"];
        model.imgURL = [NSString stringWithFormat:@"http://192.168.10.104/%@",[dicFlow objectForKey:@"imgURL"]];
        [_arrOfImages addObject:model];
        
    }
    for (NSDictionary *dicFru in arOfFruits) {
        DataModel *model = [[DataModel alloc] init];
        model.name = [dicFru objectForKey:@"name"];
        model.imgURL = [NSString stringWithFormat:@"http://192.168.10.104/%@",[dicFru objectForKey:@"imgURL"]];
        [_arrOfImages addObject:model];
        
    }
    for (NSDictionary *dicTech in arOfTechnology) {
        DataModel *model = [[DataModel alloc] init];
        model.name = [dicTech objectForKey:@"name"];
        model.imgURL = [NSString stringWithFormat:@"http://192.168.10.104/%@",[dicTech objectForKey:@"imgURL"]];
        [_arrOfImages addObject:model];
        
    }
    for (NSDictionary *dicVeg in arOfVegetables) {
        DataModel *model = [[DataModel alloc] init];
        model.name = [dicVeg objectForKey:@"name"];
        model.imgURL = [NSString stringWithFormat:@"http://192.168.10.104/%@",[dicVeg objectForKey:@"imgURL"]];
        [_arrOfImages addObject:model];
    }
    
    [tblview reloadData];
}
@end
