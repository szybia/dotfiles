#!/usr/bin/env bash
# ramp-stress.sh - ramp stress-ng CPU load over a window to find the
# contention level where the flaky test starts failing.
set -uo pipefail

START_PCT=${START_PCT:-10}      # starting CPU %
END_PCT=${END_PCT:-80}          # ending CPU %
STEP_PCT=${STEP_PCT:-10}        # increment per step
TOTAL_HOURS=${TOTAL_HOURS:-24}  # total ramp duration
MODE=${MODE:-load}              # load = --cpu-load on all cores; cores = N full-load workers
LOG=${LOG:-stress-ramp.log}
NCPU=$(nproc 2>/dev/null || sysctl -n hw.ncpu)

n_steps=$(( (END_PCT - START_PCT) / STEP_PCT + 1 ))
step_secs=${STEP_SECS:-$(( TOTAL_HOURS * 3600 / n_steps ))}

log(){ printf '[%s] %s\n' "$(date -u +%FT%TZ)" "$*" | tee -a "$LOG"; }

STRESS_PID=""
cleanup(){ [ -n "${STRESS_PID:-}" ] && kill "$STRESS_PID" 2>/dev/null; }
trap 'cleanup; log "interrupted"; exit 0' INT TERM
trap cleanup EXIT

log "ramp ${START_PCT}%->${END_PCT}% step ${STEP_PCT}% over ${TOTAL_HOURS}h | ${n_steps} steps x ${step_secs}s | nproc=${NCPU} | mode=${MODE}"

for (( pct=START_PCT; pct<=END_PCT; pct+=STEP_PCT )); do
  if [ "$MODE" = "cores" ]; then
    workers=$(( (NCPU * pct + 99) / 100 )); [ "$workers" -lt 1 ] && workers=1
    log "ACTIVE LEVEL ${pct}% -> stress-ng --cpu ${workers} (100% load) for ${step_secs}s"
    stress-ng --cpu "$workers" --timeout "${step_secs}s" --metrics-brief >>"$LOG" 2>&1 &
  else
    log "ACTIVE LEVEL ${pct}% -> stress-ng --cpu 0 --cpu-load ${pct} for ${step_secs}s"
    stress-ng --cpu 0 --cpu-load "$pct" --timeout "${step_secs}s" --metrics-brief >>"$LOG" 2>&1 &
  fi
  STRESS_PID=$!
  wait "$STRESS_PID"
  STRESS_PID=""
done

log "ramp complete"
