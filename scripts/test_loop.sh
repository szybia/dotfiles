#!/bin/bash

iters=50
LOG=${LOG:-test-iter.log}
seconds=0
runs=0
while true; do
  ((runs++))

  # truncate the log + write a header, so a hung/reset VM still shows
  # which run was in flight and when it started
  printf '=== run #%d | started %s ===\n' "$runs" "$(date -u +%FT%TZ)" > "$LOG"

  ./gradlew ":x-pack:plugin:stateless:internalClusterTest" --tests "org.elasticsearch.xpack.stateless.recovery.BlockRefreshUponIndexCreationIT.testIndexWithZeroReplicasAndAutoExpandReplicasHasClusterBlocks" -Dtests.seed=F2DC4B51ECD81812 -Dtests.locale=en-MG -Dtests.timezone=Europe/Tirane -Druntime.java=26 \
        -Dtests.timestamp=$(date +%s) \
        -Dtests.nightly=true \
        -Dtests.failfast=true \
        -Dtests.iters=$iters \
        -Dtests.leavetmpdir=false \
        >> "$LOG" 2>&1
  rc=$?

  if [[ "$rc" -ne 0 ]]; then
      duration=$SECONDS
      {
        echo "------------------------------------------------------------"
        echo "FAILED after $runs runs! (gradle exit $rc)"
        echo "Duration: $((duration / 60)) minutes and $((duration % 60)) seconds."
        echo "------------------------------------------------------------"
      } | tee -a "$LOG"
      break
  fi

  duration=$SECONDS
  echo "Completed run #$runs. Running since $((duration / 60)) minutes and $((duration % 60)) seconds." | tee -a "$LOG"
done
