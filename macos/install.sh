set -euc

#  DNS
networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844
# finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.desktopservices "DSDontWriteNetworkStores" -bool "true"
killall Finder
