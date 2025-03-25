#!/bin/bash

# brew install duti

duti -s com.apple.Safari public.html all
duti -s com.macromates.TextMate com.apple.property-list all
duti -s com.macromates.TextMate com.apple.storyboard all
duti -s com.macromates.TextMate com.apple.strings-text all
duti -s com.macromates.TextMate com.apple.xcconfig all
duti -s com.macromates.TextMate com.apple.xcsettings all
duti -s com.macromates.TextMate com.apple.xib all
duti -s com.macromates.TextMate net.daringfireball.markdown all
duti -s com.macromates.TextMate public.c-header all
duti -s com.macromates.TextMate public.c-plus-plus-source all
duti -s com.macromates.TextMate public.c-source all
duti -s com.macromates.TextMate public.comma-separated-values-text all
duti -s com.macromates.TextMate public.json all
duti -s com.macromates.TextMate public.objective-c-plus-plus-source all
duti -s com.macromates.TextMate public.objective-c-source all
duti -s com.macromates.TextMate public.plain-text all
duti -s com.macromates.TextMate public.swift-source all
duti -s com.macromates.TextMate public.xml all
duti -s com.macromates.TextMate public.yaml all
duti -s com.macromates.TextMate.com.apple.property-list com.apple.property-list all
duti -s com.macromates.TextMate.net.daringfireball.markdown net.daringfireball.markdown all
duti -s com.macromates.TextMate.public.comma-separated-values-text public.comma-separated-values-text all
duti -s com.macromates.TextMate.public.json public.json all
duti -s com.macromates.TextMate.public.plain-text public.plain-text all
duti -s com.macromates.TextMate.public.xml public.xml all

killall Finder
