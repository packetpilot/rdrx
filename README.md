# rdrx

## [Overview]
While at #lastjob, I had a simple solution to deal with a growing list of
internal URLs, and used it to scratch an itch that DNS couldn't reach.

Admittedly, Google's "go/" shortener was the inspiration, although this is only
what I'd call a half-baked attempt at best, although I'd wager a company can
grow quite a bit before even the weakest webserver hosting this would be taxed.

This is by no means novel, but I figure it may be useful to some.

PRs to enhance are of course welcome.

If leveraging this company-wide, a (private/internal) DNS entry is the way to
go. Ensure the DNS completion path (what macOS & OS X call "Search Domains") on
your users' systems is managed if doing so, since 'ac/jira' is much quicker than
'ac.corp.acme.com/jira'.

Lastly, text [in square brackets] is intended for the sysadmin audience, as the
rest is relevant to leave up for the company's (git-server-accessing) wider
audience.

## Description
Simple redirects for bookmark-free ACMECO internal sites navigation, easily.

## Use
[Omit the following two lines if an internal DNS entry is made~~, or if you dare
to manage users' /etc/hosts file~~.]

For browser URL shortcuts such as "ac/jira" etc., place the following line in
/etc/hosts:

``10.10.10.10 ac``

*Note: shortcuts will only work while connected to the VPN or on the corp net*

## [Server Setup]
This assumes a default Apache server without any concurrent sites, hence the
"000-default.conf" name of the provided Apache file.

Ensure you've got some mechanism by which master deploys to the webserver.

## Shortcut Contributions [ACMECO user-facing]
- Please keep redirect contributions alphabetized.
- After a a merge to master, the redirect will be live momentarily.
- Use the pre-commit hook to auto-update this README's list of redirects.

## "Someday"
- Custom 404 with a form for magical ingestion/addition of a shortcut
- Automation elegance via deploy hook as part of the repo
- Auto-generation of the Apache file via $something ingestion (yaml?)

## Redirects (auto-updated via hook, do not manually edit)
Shortcut | Long URL
--- | ---
` ac/aws ` | ` https://ACMECO.signin.aws.amazon.com/console `
` ac/confluence ` | ` https://ACMECO.atlassian.net/wiki `
` ac/facilities ` | ` https://ACMECO.atlassian.net/servicedesk/customer/portal/1 `
` ac/finance ` | ` https://sites.google.com/a/ACMECO/finance `
` ac/gcp ` | ` https://console.cloud.google.com/home `
` ac/gdoc ` | ` https://goo.gl/AcM3Co `
` ac/git ` | ` https://github.com/ACMECO `
` ac/github ` | ` https://github.com/ACMECO `
` ac/gitlab ` | ` https://gitlab.ACMECO.com `
` ac/grafana ` | ` https://grafana.prod.ACMECO.com `
` ac/hbase ` | ` https://hbase.prod.ACMECO.com/master-status `
` ac/hr ` | ` https://ACMECO.whateverthenewhipHRIS.is `
` ac/hr! ` | ` mailto:hr@ACMECO.com `
` ac/ithelp ` | ` https://ACMECO.atlassian.net/servicedesk/customer/portal/2 `
` ac/jira ` | ` https://ACMECO.atlassian.net/secure/Dashboard.jspa `
` ac/mapr ` | ` https://mapr.prod.ACMECO.com `
` ac/observium ` | ` https://observium.ACMECO.com `
` ac/po ` | ` https://productioncloud2.verian.com/Prod2/SomeRidiculouslyLongThingBecauseFinanceSoftware,Apparently `
` ac/pd ` | ` https://ACMECO.pagerduty.com `
` ac/slack ` | ` https://ACMECO.slack.com `
` ac/who ` | ` https://www.google.com/contacts/?cplus=0#contacts/group/27/Directory `
