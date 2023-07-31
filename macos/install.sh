set -eux

#  DNS
networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844
# finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.desktopservices "DSDontWriteNetworkStores" -bool "true"
killall Finder
# vscode (vim extention)
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false 
# rectangle
defaults write com.knollsoft.Rectangle snapEdgeMarginTop -int 30
defaults write com.knollsoft.Rectangle snapEdgeMarginBottom -int 30
defaults write com.knollsoft.Rectangle snapEdgeMarginLeft -int 30
defaults write com.knollsoft.Rectangle snapEdgeMarginRight -int 30
