//
//  main.m
//  ObjC-DataTypes
//
//  Created by Tsering Lama on 4/27/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 count: return the number of items in an array.
 indexOfObject: returns the location of an item in an array.
 objectAtIndex: returns the object at a location in an array. (The counterpart of indexOfObject)
 componentsJoinedByString: converts an array into a string, using another string as glue
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // MARK: NSArray
        NSArray *names = @[@"Faker", @"Bang", @"Bengi"];
        
        //fast enummuration
        for (NSString *name in names) {
            NSLog(@"%@", name);
        }
        
        // reverse enumuration
        for (NSString *name in [names reverseObjectEnumerator]) {
            NSLog(@"Reverse %@", name);
        }
        
        NSLog(@"My favorite is %@", names[0]); // or objectAtIndex: 0
        
        // array literals
        // NSArray needs it to know where your list of items ends
        NSArray *things = [NSArray arrayWithObjects:@"Food", @"Water", @"Fire", nil];
        
        // MARK: Mutable Arrays
        NSMutableArray *newThings = [@[@"Weeping Angels", @"Cybermen", @"Daleks"] mutableCopy];
        [newThings addObject:@"Ward"];
        [newThings addObjectsFromArray:names];
        [newThings insertObject:@"The Silence" atIndex:1];
        [newThings removeObjectAtIndex:3];
        [newThings removeAllObjects];
        
        // MARK: Sorting
        // NSString has a built-in method called COMPARE, which compares one string against another and returns whether string A comes before or after string B, or should be sorted the same
        // We can use compare to sort an array by using it with the sortedArrayUsingSelector method
        
        NSArray *sortedNames = [names sortedArrayUsingSelector:@selector(compare:)];

        // MARK: Functional techniques
        // makeObjectsPerformSelector - run a method on every item in the array
        
        // enumerateObjectsUsingBlock - blocks , proto closures
        [names enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            // ^ caret symbol
            // obj (data type id) - AnyObject
            // idx - position of the current item in the array
            // bool - By passing a pointer to a boolean, you can modify its contents (“please stop looping now”) and that change will be visible outside the block
            NSLog(@"Can the Doctor defeat %@? Yes he can!", obj);
        }];
        
        [names enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:@"Bang"]) {
                NSLog(@"Oh u cant go past %@", obj);
                // stop when it gets to bang
                *stop = true; // change the value that stop is pointing to
            } else {
                NSLog(@"Sup %@", obj);
            }
        }];
        
        // filteredArrayUsingPredicate - filter() in Swift
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id obj, NSDictionary *bindings) {
            return [[obj componentsSeparatedByString:@" "] count] == 1;
        }];
        NSArray *oneCount = [names filteredArrayUsingPredicate:predicate];
        NSLog(@"one count %@", oneCount);
        
        // MARK: Key paths
        // key value observing
        NSArray *numbers = [NSArray arrayWithObjects:@1, @2, @3, @4, @5, nil];
        NSNumber *sum = [numbers valueForKeyPath:@"@sum.self"]; // sum, avg, min, max 
        NSLog(@"The sum on numbers is %@", sum);

    }
    return 0;
}
