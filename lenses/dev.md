# Lens: Developer surface (CLI, API, SDK, config)

For command-line tools, REST/RPC APIs, SDKs, libraries, and config formats. The doctrine's "it just
works" and "say no" apply just as hard to developers as to consumers — Apple holds developer surfaces
(Swift, the SDKs, Xcode templates) to the same bar. These are the tests unique to a developer surface.

## Zero-config happy path
Does the most common task work without reading the docs or setting a single flag? The best API call is
the one a developer guesses correctly on the first try. Count the steps from install to first success.
Every required flag with no sensible default, every mandatory config key, is a tax charged before any
value — exactly the "it just works" test, in a terminal.

## Verb and surface sprawl
How many commands, subcommands, or endpoints are there, and are the verbs consistent? `get/list/create`
everywhere beats `get` here, `fetch` there, `retrieve` somewhere else. Inconsistent naming across a
surface is the seam (doctrine #3) where the developer's mental model breaks. Flag the sprawl and the
inconsistency, and name what to collapse.

## One obvious way
Is there one clear way to do the common thing, or three half-overlapping ways (a flag, an env var, and
a config key that all set the same thing)? Multiple paths to the same outcome is the unfocused hedging
of doctrine #2, and it doubles the surface a user must learn and you must maintain. Pick one, deprecate
the rest.

## Error messages are the product
When something goes wrong, does the message say *what* failed and *what to do next* — or just throw a
stack trace and a code? Error copy is the detail no spec forces you to get right, which is exactly
where taste lives (doctrine #7). A great error message turns a dead end into a next step.

## Least astonishment
Does anything do more than its name says — a "read" command that writes, a flag with a surprising side
effect, a default that mutates state or phones home? Surprising behavior is the developer-surface
violation of both "it just works" and privacy (doctrine #6). Flag every astonishment.

## Output restraint
Does the tool dump walls of log noise, or show what matters and stay quiet otherwise? Verbose-by-
default is clutter in a terminal. Quiet success, loud failure, detail on request.

## Built to be scripted
A CLI or API is consumed by pipelines and other programs, not just humans. Is there a `--json` (or
`--quiet`) mode for machine use? Do results go to stdout and errors/logs to stderr, so a script can
separate them? Are exit codes stable and meaningful? Human-friendly defaults are right — but a
developer surface that can't be scripted cleanly fails the 90% case for its actual users.

## A cut needs a migration path
Before recommending you delete a command, endpoint, or flag, remember there's an installed base you
can't see depending on it. Apple's own developer surfaces obsess over deprecation warnings and
migration guides for exactly this reason. The right move is usually deprecate-then-remove — an alias
period and a clear warning — not a silent breaking change. A cut without a migration path breaks every
script that already calls the old name, so pair structural cuts on a shipped surface with how to get
there without breaking users.
