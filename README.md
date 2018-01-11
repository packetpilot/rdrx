# rdrx
URL simplicity via redirects, because bookmarks are for books.


## Overview
_This is by no means novel, but I figure it may be useful to some._

rdrx aims to simplify URLs that you frequently visit, but can't always recall.
It does so via a docker container, which can run on your machine, or, if
leveraging this for a workplace, on some internally-accessible server.

| what had been... | ...is now |
| ---------------- | --------- |
| portal.some-obscure-unhelpful.name/login.foo | g0/paystubs |

rdrx can also handle `mailto:` links, so "g0/help!" or "g0/security!" can be an
easy way to shave off a little time that could make a big difference.


## Backstory
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
users' systems is managed if doing so, since 'ua/jira' is much quicker than
'ua.corp.urbanairship.com/jira'.


## Local Use
### Prerequisites
1. You're on a Linux or macOS box and:
   * have the following in your $PATH:
     * [`jq`](https://stedolan.github.io/jq/download/)
     * [`docker`](https://www.docker.com/get-docker)
     * GNU `sed` and GNU `date`
       * macOS users take note: `brew install coreutils` will install these (and
         some others); `--with-default-names` is not required
       * the `brew` command assumes you've got [homebrew](https://brew.sh/)
         installed
     * Things that are almost certainly already there, like `sort`, `curl`, and
       `echo`
   * aren't hosting anything from that box on port 80 (although port
     customization is easily achieved in the [pre-commit-hook](pre-commit-hook)).
1. Ensure your `/etc/hosts` file contains the line:
   `127.0.0.1 g0`
1. Be sure to link the [pre-commit-hook](pre-commit-hook):
   `ln -s ../../pre-commit-hook .git/hooks/pre-commit # from top of the repo`
   It _should_ helpfully let you know what's missing wrt the above.


### Updating the Redirects
 1. Modify *only* the [`addr.json`](addr.json) file (disregard line order);
    "name" and "target" key/value pairs must exist for each line.
 1. _WARNING: The pre-commit hook herein is aggressive, as described below._

    Commit; the [pre-commit-hook](pre-commit-hook) will:
    * `sort` [`addr.json`](addr.json)
    * generate the [Redirects table in the README](README.md#redirects-do-not-manually-edit)
    * generate of the [rdrx.conf](rdrx.conf) file
    * stop and remove a pre-existing docker container
    * build and start a fresh docker container (total downtime is ~3s on a modern
      MacBook Pro)
    * run helpful tests along the way, with some red/green color coding, and
      helpful output along the way, as so:

      ![Graphic](https://i.imgur.com/r1u0vbP.png?raw=true)


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
g0/aws|https://ACMECO.signin.aws.amazon.com/console
g0/confluence|https://ACMECO.atlassian.net/wiki
g0/facilities|https://ACMECO.atlassian.net/servicedesk/customer/portal/1
g0/finance|https://sites.google.com/a/ACMECO/finance
g0/gcp|https://console.cloud.google.com/home
g0/gdoc|https://goo.gl/AcM3Co
g0/git|https://github.com/ACMECO
g0/github|https://github.com/ACMECO
g0/gitlab|https://gitlab.ACMECO.com
g0/grafana|https://grafana.prod.ACMECO.com
g0/hbase|https://hbase.prod.ACMECO.com/master-status
g0/hr!|mailto:hr@ACMECO.com?subject=Ohnoes&body=https://goo.gl/acqZJE
g0/hr|https://ACMECO.whateverthenewhipHRIS.is
g0/ithelp|https://ACMECO.atlassian.net/servicedesk/customer/portal/2
g0/jira|https://ACMECO.atlassian.net/secure/Dashboard.jspa
g0/mapr|https://mapr.prod.ACMECO.com
g0/observium|https://observium.ACMECO.com
g0/pd|https://ACMECO.pagerduty.com
g0/po|https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently
g0/security!|mailto:security@ACMECO.com
g0/slack|https://ACMECO.slack.com
g0/who|https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory
