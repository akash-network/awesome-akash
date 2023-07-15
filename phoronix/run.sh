#!/usr/bin/env sh
./phoronix-test-suite/phoronix-test-suite batch-setup << EOF
n
Y
EOF
/phoronix-test-suite/phoronix-test-suite install-dependencies $TEST
./phoronix-test-suite/phoronix-test-suite $COMMAND $TEST
