#!/bin/sh

if [[ "$1" != "-d" ]]; then
	echo "Removing animations"
	defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
	defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
	defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
	# defaults write -g NSScrollAnimationEnabled -bool false
	defaults write -g NSWindowResizeTime -float 0.001
	defaults write -g QLPanelAnimationDuration -float 0
	defaults write -g NSScrollViewRubberbanding -bool false
	defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
	defaults write -g NSToolbarFullScreenAnimationDuration -float 0
	defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
	defaults write com.apple.dock autohide-delay -float 10
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock no-bouncing -bool true
	# defaults write com.apple.dock autohide-time-modifier -float 2
	defaults write com.apple.dock expose-animation-duration -float 0
	defaults write com.apple.dock springboard-show-duration -float 0
	defaults write com.apple.dock springboard-hide-duration -float 0
	defaults write com.apple.dock springboard-page-duration -float 0
	defaults write com.apple.finder DisableAllAnimations -bool true
	defaults write com.apple.Mail DisableSendAnimations -bool true
	defaults write com.apple.Mail DisableReplyAnimations -bool true
else
	echo "Back to the default animations"
	defaults delete -g NSAutomaticWindowAnimationsEnabled
	defaults delete NSGlobalDomain NSWindowResizeTime
	defaults delete -g NSAutomaticWindowAnimationsEnabled
	defaults delete -g NSScrollAnimationEnabled
	defaults delete -g NSWindowResizeTime
	defaults delete -g QLPanelAnimationDuration
	defaults delete -g NSScrollViewRubberbanding
	defaults delete -g NSDocumentRevisionsWindowTransformAnimation
	defaults delete -g NSToolbarFullScreenAnimationDuration
	defaults delete -g NSBrowserColumnAnimationSpeedMultiplier
	defaults delete com.apple.dock autohide-time-modifier
	defaults delete com.apple.dock autohide-delay
	defaults delete com.apple.dock expose-animation-duration
	defaults delete com.apple.dock springboard-show-duration
	defaults delete com.apple.dock springboard-hide-duration
	defaults delete com.apple.dock springboard-page-duration
	defaults delete com.apple.finder DisableAllAnimations
	defaults delete com.apple.Mail DisableSendAnimations
	defaults delete com.apple.Mail DisableReplyAnimations
	defaults delete com.apple.Dock autohide-delay
fi

killall Dock
