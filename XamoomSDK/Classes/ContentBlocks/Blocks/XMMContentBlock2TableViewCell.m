//
// Copyright 2015 by xamoom GmbH <apps@xamoom.com>
//
// This file is part of some open source application.
//
// Some open source application is free software: you can redistribute
// it and/or modify it under the terms of the GNU General Public
// License as published by the Free Software Foundation, either
// version 2 of the License, or (at your option) any later version.
//
// Some open source application is distributed in the hope that it will
// be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
// of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with xamoom-ios-sdk. If not, see <http://www.gnu.org/licenses/>.
//

#import "XMMContentBlock2TableViewCell.h"

@interface XMMContentBlock2TableViewCell()

@property (strong, nonatomic) NSString* videoUrl;
@property (nonatomic) float screenWidth;
@property (nonatomic) UITapGestureRecognizer *tappedVideoViewRecognize;

@end

@implementation XMMContentBlock2TableViewCell

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)initVideoWithUrl:(NSString*)videoUrl {
  self.videoPlayer = nil;
  self.tappedVideoViewRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedVideoView:)];
  [self.thumbnailImageView addGestureRecognizer:self.tappedVideoViewRecognize];

  NSString* youtubeVideoId = [self youtubeVideoIdFromUrl:videoUrl];

  if (youtubeVideoId != nil) {
    //load video inside playerView
    self.playerView.hidden = NO;
    self.playIconImageView.hidden = YES;
    self.thumbnailImageView.hidden = YES;
    [self.playerView loadWithVideoId:youtubeVideoId];
  } else {
    self.playerView.hidden = YES;
    self.playIconImageView.hidden = NO;
    self.thumbnailImageView.hidden = NO;
    self.videoUrl = videoUrl;

    [self initVideoPlayer];
  }
}

/**
 *  Returns the videoId from a youtubeUrl.
 *
 *  @param videoUrl youtube url.
 *
 *  @return String videoId
 */
- (NSString*)youtubeVideoIdFromUrl:(NSString*)videoUrl {
  //get the youtube videoId from the string
  NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
  NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                          options:NSRegularExpressionCaseInsensitive
                                                                            error:nil];
  NSArray *array = [regExp matchesInString:videoUrl options:0 range:NSMakeRange(0,videoUrl.length)];
  
  if(array.count == 1) {
    NSTextCheckingResult *result = array.firstObject;
    return [videoUrl substringWithRange:result.range];;
  } else {
    return nil;
  }
}

/**
 *  Creates and inits the videoplayer.
 *  Adds a gesture recognizer when tapping on the playerView, adds a notificication, and downloads
 *  a imagethumbnail for the video.
 */
- (void)initVideoPlayer {
  self.videoPlayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString:self.videoUrl]];
  self.videoPlayer.shouldAutoplay = NO;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(didReceiveImage:)
                                               name:MPMoviePlayerThumbnailImageRequestDidFinishNotification
                                             object:self.videoPlayer];
  
  NSArray *timeArray = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0], nil];
  [self.videoPlayer requestThumbnailImagesAtTimes:timeArray timeOption:MPMovieTimeOptionNearestKeyFrame];
}

- (void)tappedVideoView:(UITapGestureRecognizer*)sender {
  MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:  self.videoPlayer.contentURL];
  [self.window.rootViewController presentMoviePlayerViewControllerAnimated:mpvc];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleMoviePlayerFinish:)
                                               name:MPMoviePlayerWillExitFullscreenNotification
                                             object:nil];
}

- (void)handleMoviePlayerFinish:(NSNotification*)notification{
  NSDictionary *notificationUserInfo = [notification userInfo];
  NSNumber *resultValue = [notificationUserInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
  MPMovieFinishReason reason = [resultValue intValue];
  if (reason == MPMovieFinishReasonPlaybackError)
  {
    NSError *mediaPlayerError = [notificationUserInfo objectForKey:@"error"];
    if (mediaPlayerError)
    {
      NSLog(@"playback failed with error description: %@", [mediaPlayerError localizedDescription]);
    }
    else
    {
      NSLog(@"playback failed without any given reason");
    }
  }
  
  [self.videoPlayer.view removeFromSuperview];
  [[NSNotificationCenter defaultCenter] removeObserver:MPMoviePlayerPlaybackDidFinishNotification];
}

- (void)didReceiveImage:(NSNotification*)notification {
  NSDictionary *userInfo = [notification userInfo];
  UIImage *image = [userInfo valueForKey:MPMoviePlayerThumbnailImageKey];
  self.thumbnailImageView.image = image;
}

- (void)configureForCell:(XMMContentBlock *)block {
  if(block.title != nil && ![block.title isEqualToString:@""])
    self.titleLabel.text = block.title;
  
  [self initVideoWithUrl:block.videoUrl];
}

@end
