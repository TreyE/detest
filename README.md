# Detest

[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

A dynamically distributed ruby test runner.

How Detest works:
1. Start a publisher which collects a list of all test files to be run.
2. Put that list of files into a Redis set.
3. Run a list of workers which pull files 1-by-1 from the list until there is no work left.

This is in contrast to other distributed testing frameworks, which attempt to either guess how to distribute test files ahead of time, or rely on previous measurements.

Previous measurements aren't good in some cases because:
1. The amount of time a file takes to run can vary and change over time.
2. If your test suite takes a long time to run, you at some point will need to run and measure all of the files in the suite - which can take quite a while.

Added bonuses of this approach:
1. You can augment and upgrade the testing approach, including adding measurement instrumentation, just by upgrading the adapter.  You need do nothing to your code, just upgrade the gem.
2. The since the adapter handles how work is divided, changes in testing strategy can be adapted in the gem with no change to the target project source code.

## Supported Test Frameworks

Currently Detest only supports RSpec.

## Outstanding Features

Support for Cucumber is planned once RSpec support is stable.
