#!/usr/bin/env bash
# PreToolUse hook for mcp__Supabase__execute_sql: lets SELECT / INSERT / UPDATE
# through and blocks delete, drop, truncate, alter, create, grant, revoke, copy.
# Best-effort keyword check on the raw tool input, not a SQL parser: it can
# over-block (a string literal containing "delete") and is not a security
# boundary. Real enforcement belongs in database privileges.
input=$(cat)
if printf '%s' "$input" | grep -Eiq '\b(delete|drop|truncate|alter|create|grant|revoke|copy)\b'; then
  echo "Blocked: only SELECT, INSERT and UPDATE are allowed via execute_sql here. Ask Louis for anything else." >&2
  exit 2
fi
exit 0
