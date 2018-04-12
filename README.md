# rdrx
URL simplicity via redirects, because bookmarks are for books.


## Overview
This is by no means novel, but I figure it may be useful to some.

While at #lastjob, I had a simple solution to smooth UX around a growing list of
internal URLs, and used it to scratch an itch that DNS couldn't reach: a list of
301 redirects on an apache server. Google's "go/" shortener (for corp use by
employees etc.) served as inspiration for what had initially been devoid of any
magic whatsoever. This project aims to tackle a "simple" challenge with a little
more magic, hopefully in the style of an ops engineer as opposed to a sys admin.

rdrx could easily run on a corp server with little modification, but is
presented here as a local docker implementation.

If leveraging this company-wide, a (private/internal) DNS entry is the way to
go. Ensure the DNS completion path (what macOS calls "Search Domains") on your
users' systems is managed if doing so, since 'go/jira' is much quicker than
'go.corp.urbanairship.com/jira'.


## Local Use
### Prerequisites
1. You're on a Linux or macOS box and:
   * have the following in your $PATH:
     * GNU `sed` (important for macOS; `--with-default-names` is not required)
     * [`jq`](https://stedolan.github.io/jq/download/)
     * [`docker`](https://www.docker.com/get-docker)
     * Things that are almost certainly already there, like `sort`, `curl`, and
       `echo`
   * aren't hosting anything from that box on port 80 (although port
     customization is easily achieved in the [pre-commit-hook](pre-commit-hook)).
1. Ensure your `/etc/hosts` file contains the line:
   `127.0.0.1 go`
1. Be sure to link the [pre-commit-hook](pre-commit-hook):
   `ln -s ../../pre-commit.sh .git/hooks/pre-commit # from top of the repo`
   It _should_ helpfully let you know what's missing wrt the above.


### Updating the Redirects
1. Modify *only* the [`addr.json`](addr.json) file (disregard line order);
   "name" and "target" key/value pairs must exist for each line.
1. Commit; the [pre-commit-hook](pre-commit-hook) will:
   * `sort` [`addr.json`](addr.json)
   * generate the [Redirects table in the README](README.md#redirects-do-not-manually-edit)
   * generate of the [rdrx.conf](rdrx.conf) file
   * stop and remove a pre-existing docker container
   * build and start a fresh docker container (total downtime is ~3s on a modern
     MacBook Pro)
   * run helpful tests along the way, with some red/green color coding, and
     helpful output  


## "Someday"
- [x] dockerize
- [x] json-ify
- [ ] Custom 404 with a form for magical ingestion/addition of a shortcut
- [ ] Get json from GCS/S3
- [ ] Put json into GCS/S3 from a Google Sheet (for 'zero-chops admin')
- [ ] Analytics support
- [ ] Prometheus exporter


## Redirects (do not manually edit)
Shortcut | URL
--- | ---
go/aws|https://ACMECO.signin.aws.amazon.com/console
go/confluence|https://ACMECO.atlassian.net/wiki
go/facilities|https://ACMECO.atlassian.net/servicedesk/customer/portal/1
go/finance|https://sites.google.com/a/ACMECO/finance
go/gcp|https://console.cloud.google.com/home
go/gdoc|https://goo.gl/AcM3Co
go/git|https://github.com/ACMECO
go/github|https://github.com/ACMECO
go/gitlab|https://gitlab.ACMECO.com
go/grafana|https://grafana.prod.ACMECO.com
go/hbase|https://hbase.prod.ACMECO.com/master-status
go/hr!|mailto:hr@ACMECO.com?subject=Ohnoes&body=https://goo.gl/acqZJE
go/hr|https://ACMECO.whateverthenewhipHRIS.is
go/ithelp|https://ACMECO.atlassian.net/servicedesk/customer/portal/2
go/jira|https://ACMECO.atlassian.net/secure/Dashboard.jspa
go/mapr|https://mapr.prod.ACMECO.com
go/observium|https://observium.ACMECO.com
go/pd|https://ACMECO.pagerduty.com
go/po|https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently
go/security!|mailto:security@ACMECO.com
go/slack|https://ACMECO.slack.com
go/who|https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory
## Redirects (do not manually edit)
Shortcut | URL
--- | ---
go/aws|https://ACMECO.signin.aws.amazon.com/console
go/confluence|https://ACMECO.atlassian.net/wiki
go/facilities|https://ACMECO.atlassian.net/servicedesk/customer/portal/1
go/finance|https://sites.google.com/a/ACMECO/finance
go/gcp|https://console.cloud.google.com/home
go/gdoc|https://goo.gl/AcM3Co
go/git|https://github.com/ACMECO
go/github|https://github.com/ACMECO
go/gitlab|https://gitlab.ACMECO.com
go/grafana|https://grafana.prod.ACMECO.com
go/hbase|https://hbase.prod.ACMECO.com/master-status
go/hr!|mailto:hr@ACMECO.com?subject=Ohnoes&body=https://goo.gl/acqZJE
go/hr|https://ACMECO.whateverthenewhipHRIS.is
go/ithelp|https://ACMECO.atlassian.net/servicedesk/customer/portal/2
go/jira|https://ACMECO.atlassian.net/secure/Dashboard.jspa
go/mapr|https://mapr.prod.ACMECO.com
go/observium|https://observium.ACMECO.com
go/pd|https://ACMECO.pagerduty.com
go/po|https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently
go/security!|mailto:security@ACMECO.com
go/slack|https://ACMECO.slack.com
go/who|https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory
## Redirects (do not manually edit)
Shortcut | URL
--- | ---
go/amazon|https://www.amazon.com
go/confluence|https://ACMECO.atlassian.net/wiki
go/facilities|https://ACMECO.atlassian.net/servicedesk/customer/portal/1
go/finance|https://sites.google.com/a/ACMECO/finance
go/gcp|https://console.cloud.google.com/home
go/gdoc|https://goo.gl/AcM3Co
go/git|https://github.com/ACMECO
go/github|https://github.com/ACMECO
go/gitlab|https://gitlab.ACMECO.com
go/grafana|https://grafana.prod.ACMECO.com
go/hbase|https://hbase.prod.ACMECO.com/master-status
go/hr!|mailto:hr@ACMECO.com?subject=Ohnoes&body=https://goo.gl/acqZJE
go/hr|https://ACMECO.whateverthenewhipHRIS.is
go/ithelp|https://ACMECO.atlassian.net/servicedesk/customer/portal/2
go/jira|https://ACMECO.atlassian.net/secure/Dashboard.jspa
go/mapr|https://mapr.prod.ACMECO.com
go/observium|https://observium.ACMECO.com
go/pd|https://ACMECO.pagerduty.com
go/po|https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently
go/security!|mailto:security@ACMECO.com
go/slack|https://ACMECO.slack.com
go/who|https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory
## Redirects (do not manually edit)
Shortcut | URL
--- | ---
go/amazon|https://www.amazon.com
go/confluence|https://ACMECO.atlassian.net/wiki
go/facilities|https://ACMECO.atlassian.net/servicedesk/customer/portal/1
go/finance|https://sites.google.com/a/ACMECO/finance
go/gcp|https://console.cloud.google.com/home
go/gdoc|https://goo.gl/AcM3Co
go/git|https://github.com/ACMECO
go/github|https://github.com/ACMECO
go/gitlab|https://gitlab.ACMECO.com
go/grafana|https://grafana.prod.ACMECO.com
go/hbase|https://hbase.prod.ACMECO.com/master-status
go/hr!|mailto:hr@ACMECO.com?subject=Ohnoes&body=https://goo.gl/acqZJE
go/hr|https://ACMECO.whateverthenewhipHRIS.is
go/ithelp|https://ACMECO.atlassian.net/servicedesk/customer/portal/2
go/jira|https://ACMECO.atlassian.net/secure/Dashboard.jspa
go/mapr|https://mapr.prod.ACMECO.com
go/observium|https://observium.ACMECO.com
go/pd|https://ACMECO.pagerduty.com
go/po|https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently
go/security!|mailto:security@ACMECO.com
go/slack|https://ACMECO.slack.com
go/who|https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory
## Redirects (do not manually edit)
Shortcut | URL
--- | ---
go/amazon|https://www.amazon.com
go/confluence|https://ACMECO.atlassian.net/wiki
go/facilities|https://ACMECO.atlassian.net/servicedesk/customer/portal/1
go/finance|https://sites.google.com/a/ACMECO/finance
go/gcp|https://console.cloud.google.com/home
go/gdoc|https://goo.gl/AcM3Co
go/git|https://github.com/ACMECO
go/github|https://github.com/ACMECO
go/gitlab|https://gitlab.ACMECO.com
go/grafana|https://grafana.prod.ACMECO.com
go/hbase|https://hbase.prod.ACMECO.com/master-status
go/hr!|mailto:hr@ACMECO.com?subject=Ohnoes&body=https://goo.gl/acqZJE
go/hr|https://ACMECO.whateverthenewhipHRIS.is
go/ithelp|https://ACMECO.atlassian.net/servicedesk/customer/portal/2
go/jira|https://ACMECO.atlassian.net/secure/Dashboard.jspa
go/mapr|https://mapr.prod.ACMECO.com
go/observium|https://observium.ACMECO.com
go/pd|https://ACMECO.pagerduty.com
go/po|https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently
go/security!|mailto:security@ACMECO.com
go/slack|https://ACMECO.slack.com
go/who|https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory
## Redirects (do not manually edit)
Shortcut | URL
--- | ---
go/amazon|https://www.amazon.com
go/confluence|https://ACMECO.atlassian.net/wiki
go/facilities|https://ACMECO.atlassian.net/servicedesk/customer/portal/1
go/finance|https://sites.google.com/a/ACMECO/finance
go/gcp|https://console.cloud.google.com/home
go/gdoc|https://goo.gl/AcM3Co
go/git|https://github.com/ACMECO
go/github|https://github.com/ACMECO
go/gitlab|https://gitlab.ACMECO.com
go/grafana|https://grafana.prod.ACMECO.com
go/hbase|https://hbase.prod.ACMECO.com/master-status
go/hr!|mailto:hr@ACMECO.com?subject=Ohnoes&body=https://goo.gl/acqZJE
go/hr|https://ACMECO.whateverthenewhipHRIS.is
go/ithelp|https://ACMECO.atlassian.net/servicedesk/customer/portal/2
go/jira|https://ACMECO.atlassian.net/secure/Dashboard.jspa
go/linkedin|https://www.linkedin.com
go/mapr|https://mapr.prod.ACMECO.com
go/observium|https://observium.ACMECO.com
go/pd|https://ACMECO.pagerduty.com
go/po|https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently
go/security!|mailto:security@ACMECO.com
go/slack|https://ACMECO.slack.com
go/who|https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory
go/youtube|https://www.youtube.com
