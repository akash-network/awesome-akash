# Phoronix Test Suite

![Phoronix Test Suite](pts-core/static/images/pts-308x160.png)

[Phoronix Test Suite
Documentation](https://github.com/phoronix-test-suite/phoronix-test-suite/blob/master/documentation/phoronix-test-suite.md)

The Phoronix Test Suite itself is an open-source framework for conducting
automated tests along with reporting of test results, detection of installed
system software/hardware, and other features. This framework is designed to be
an extensible architecture so that new test profiles and suites can be easily
added to represent performance benchmarks, unit tests, and other quantitative
and qualitative (e.g. image quality comparison and pass/fail) measurements.
Available through OpenBenchmarking.org, a collaborative storage platform
developed in conjunction with the Phoronix Test Suite, are more than 600
individual test profiles and more than 200 test suites available by default from
the Phoronix Test Suite. Independent users are also able to upload their test
results, profiles, and suites to OpenBenchmarking.org.

A test profile is a single test that can be executed by the Phoronix Test Suite
-- with a series of options possible within every test -- and a test suite is a
seamless collection of test profiles and/or additional test suites. A test
profile consists of a set of Bash/shell scripts and XML files while a test suite
is a single XML file. Modules for the Phoronix Test Suite also allow for
integration with git-bisect and other revision control systems for per-commit
regression testing, system sensor monitoring, and other extras.

[OpenBenchmarking.org](https://www.openbenchmarking.org/) also allows for
conducting side-by-side result comparisons, a central location for storing and
sharing test results, and collaborating over test data.
[Phoromatic](https://www.phoromatic.com/) is a complementary platform to
OpenBenchmarking.org and the Phoronix Test Suite for interfacing with Phoronix
Test Suite client(s) to automatically execute test runs on a timed, per-commit,
or other trigger-driven basis. Phoromatic is designed for enterprise and allows
for the easy management of multiple networked systems running Phoronix Test
Suite clients via a single web-based interface.

Professional support and custom engineering for the Phoronix Test Suite,
Phoromatic, and OpenBenchmarking.org is available by contacting
<https://www.phoronix-test-suite.com/>.

Full details on the Phoronix Test Suite setup and usage is available from the
included HTML/PDF documentation within the phoronix-test-suite package and from
the [Phoronix Test Suite documentation directory](documentation/).

