//
//  EventsBuilder.m
//  tuduBeta
//
//  Created by Ryan Cleary on 3/13/14.
//  Copyright (c) 2014 Jonathan Rusnak. All rights reserved.
//

#import "EventsBuilder.h"
#define id_key @"id"
#define start_time_key @"start_time"
#define end_time_key @"end_time"
#define name_key @"name"
#define description_key @"description"

@implementation EventsBuilder


+ (NSArray *) eventsFromJSON:(NSData *)objectNotation error:(NSError  **)error {
    NSError *localError = nil;
    NSMutableArray *eventsArray = [[NSMutableArray alloc] init];
    NSArray *parsedObjectArray = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    for (int i = 0; i < [parsedObjectArray count]; i++) {
        NSDictionary *eventDictionary = [parsedObjectArray objectAtIndex:i];
        [eventsArray addObject:[self eventFromDictionary:eventDictionary]];
    }
    
    return eventsArray;
}


+ (EventJSON*) eventFromJSON:(NSData *)objectNotation error:(NSError **)error {
    NSError *localError = nil;
    NSDictionary *parsedObjectDictionary = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    return [self eventFromDictionary:parsedObjectDictionary];
}


// This is what we are receiving from the back-end in the form of a JSON response:
/*{
    "id":26,
    "start_time":"2014-02-09T00:53:43.793Z",
    "end_time":"2014-02-09T02:53:55.500Z",
    "name":"my event",
    "description":"Event description.\nThis can even have newlines in it",
    "created_at":"2014-02-28T04:33:20.083Z",
    "updated_at":"2014-02-28T04:33:20.083Z"
}*/
+ (EventJSON*) eventFromDictionary:(NSDictionary*)eventDictionary {
    EventJSON *eventJSON = [[EventJSON alloc] init];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-ddEEEEEhh:mm:SSSSS"];   //2014-03-10T18:29:00.000Z     is this correct?
    
    
    if ([eventDictionary objectForKey:start_time_key] != NULL && [eventDictionary objectForKey:start_time_key] != [NSNull null]) {
        [eventJSON setStart_time:[df dateFromString:[eventDictionary objectForKey:start_time_key]]];
    }
    
    if ([eventDictionary objectForKey:end_time_key] != NULL && [eventDictionary objectForKey:end_time_key] != [NSNull null]) {
        [eventJSON setEnd_time:[df dateFromString:[eventDictionary objectForKey:end_time_key]]];
    }
    
    if ([eventDictionary objectForKey:id_key] != NULL && [eventDictionary objectForKey:id_key] != [NSNull null]) {
        [eventJSON setEvent_id:[eventDictionary objectForKey:id_key]];
    }
    
    if ([eventDictionary objectForKey:name_key] != NULL && [eventDictionary objectForKey:name_key] != [NSNull null]) {
        [eventJSON setName:[eventDictionary objectForKey:name_key]];
    }
    
    if ([eventDictionary objectForKey:description_key] != NULL && [eventDictionary objectForKey:description_key] != [NSNull null]) {
        [eventJSON setEvent_description:[eventDictionary objectForKey:description_key]];
    }
    return eventJSON;
}


@end
