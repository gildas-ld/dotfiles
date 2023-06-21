# Turn off Mozilla telemetry || Floorp is best .. Chromium 

> about:config

This sets the color scheme to prefer light mode.

You can also set it to :

dark = 0
system = 2
firefoxTheme = 3
light = 1

```ini
layout.css.prefers-color-scheme.content-override = 1
```

```ini
browser.newtabpage.activity-stream.telemetry = false
browser.newtabpage.activity-stream.telemetry.ut.events = false
datareporting.healthreport.service.enabled = false
datareporting.healthreport.uploadEnabled = false
datareporting.policy.dataSubmissionEnabled = false
toolkit.telemetry.archive.enabled = false
toolkit.telemetry.bhrPing.enabled = false
toolkit.telemetry.enabled = false
toolkit.telemetry.hybridContent.enabled = false
toolkit.telemetry.newProfilePing.enabled = false
toolkit.telemetry.prompted = 2
toolkit.telemetry.rejected = true
toolkit.telemetry.server = ""
toolkit.telemetry.shutdownPingSender.enabled = false
toolkit.telemetry.unified = false
toolkit.telemetry.unifiedIsOptIn = false
toolkit.telemetry.updatePing.enabled = false
```
