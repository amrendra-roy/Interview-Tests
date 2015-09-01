//
//  CustomCollectionView.h
//  PhotoGallery
//
//  Created by cuelogic on 01/09/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CustomCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end




static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

@interface CustomTableViewCell : UITableViewCell
{
    
}
@property (nonatomic, strong) CustomCollectionView *collectionView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdenti:(NSString *)reuseIdentifier;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end