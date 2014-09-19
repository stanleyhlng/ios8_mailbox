ios8_mailbox
============

[prototyping] Mailbox iOS8 App

[![image](https://raw.githubusercontent.com/wiki/stanleyhlng/ios8_mailbox/assets/ios8_mailbox.gif)](https://raw.githubusercontent.com/wiki/stanleyhlng/ios8_mailbox/assets/ios8_mailbox.gif)

## Overview

The purpose of this homework is to leverage animations and gestures to implement more sophisticated interactions. We're going to use the techniques from this week to implement the Mailbox interactions.

## User Stories

- [x] On dragging the message left...
    - [x] Initially, the revealed background color should be gray.
    - [x] As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
    - [x] After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
        - Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
    - [x] After 260 pts, the icon should change to the list icon and the background color should change to brown.
        - Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
- [x] User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.
- [x] On dragging the message right...
    - [x] Initially, the revealed background color should be gray.
    - [x] As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
    - [x] After 60 pts, the archive icon should start moving with the translation and the background should change to green.
        - Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
    - [x] After 260 pts, the icon should change to the delete icon and the background color should change to red.
        - Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.
- [x] Optional: Panning from the edge should reveal the menu
- [x] Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
- [x] Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.
- [x] Optional: Tapping on compose should animate to reveal the compose view.
- [x] Optional: Tapping the segmented control in the title should swipe views in from the left or right.
- [x] Optional: Shake to undo.

## Time spent
10 hours spent in total

## Libraries
```
platform :ios, '8.0'
pod 'AVHexColor', '~> 1.2.0'
pod 'Reveal-iOS-SDK'
```
