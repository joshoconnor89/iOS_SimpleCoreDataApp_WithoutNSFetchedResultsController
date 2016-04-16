//
//  Person+CoreDataProperties.h
//  coredata
//
//  Created by Joshua O'Connor on 4/15/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSNumber *weight;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
