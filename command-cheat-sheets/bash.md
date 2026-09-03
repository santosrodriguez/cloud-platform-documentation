# Bash Command Cheat Sheet

**Status:** General reference. Local workstation standards and approved tool versions are pending review.

**Audience:** Engineers using Bash for local development, troubleshooting, or automation.

**Owner:** To be confirmed.

**Last reviewed:** 2026-09-03.

Commands shown as read-only do not intentionally modify files, but their output can still disclose sensitive paths, identifiers, variables, or configuration.

## Inspect the Shell and Session

**Read-only**

```bash
bash --version
pwd
whoami
date -u
command -v terraform
command -v az
```

## Navigate and List Files

**Read-only**

```bash
pwd
ls -la
find <directory> -maxdepth 2 -type f
```

**Local change**

```bash
cd <directory>
mkdir -p <directory>
cp -i <source> <destination>
mv -i <source> <destination>
```

`cd` changes the current shell location. The other local-change commands can create, copy, or move files.

## Read Files

**Read-only**

```bash
sed -n '1,120p' <file>
head -n 20 <file>
tail -n 50 <file>
tail -f <log-file>
wc -l <file>
file <file>
```

Press `Ctrl+C` to stop `tail -f`.

## Find Files and Search Text

**Read-only**

```bash
find <directory> -type f -name '*.tf'
grep -RIn -- '<search-text>' <directory>
```

If `ripgrep` is installed, it provides faster project searches:

```bash
rg --files <directory>
rg -n -- '<search-text>' <directory>
rg -n -g '*.tf' -- '<search-text>' <directory>
```

Use `--` before user-supplied search text so a value beginning with `-` is not parsed as an option.

## Variables and Quoting

**Local change:** Exported variables are inherited by child processes.

```bash
export ARM_TENANT_ID='<tenant-id>'
export ARM_SUBSCRIPTION_ID='<subscription-id>'

printf '%s\n' "$ARM_TENANT_ID"
printf '%s\n' "$ARM_SUBSCRIPTION_ID"

unset ARM_TENANT_ID ARM_SUBSCRIPTION_ID
```

- Quote variable expansions as `"$VARIABLE"` unless intentional word splitting is required.
- Use single quotes for literal strings that must not expand variables.
- Do not run `env`, `export -p`, or shell tracing when secret variables are present because those commands can expose values.
- Do not pass secrets as command-line arguments when an approved secret-delivery method is available.

## Redirect and Capture Output

**Local change**

```bash
<command> > <output-file>
<command> >> <output-file>
<command> 2> <error-file>
<command> 2>&1 | tee <combined-log-file>
```

| Operator | Effect |
| --- | --- |
| `>` | Replaces the destination file with standard output. |
| `>>` | Appends standard output to the destination file. |
| `2>` | Sends standard error to a file. |
| `2>&1` | Sends standard error to the same destination as standard output. |
| `tee` | Displays output and writes a copy to a file. |

Review output for secrets and sensitive environment details before saving or sharing logs.

## Pipelines and Exit Status

**Read-only unless a command in the pipeline changes something**

```bash
<command> | sort
<command> | grep -- '<search-text>'
printf 'exit code: %s\n' "$?"
```

A pipeline's safety is determined by every command in it, not by the pipe itself.

## Safer Script Starting Point

```bash
#!/usr/bin/env bash
set -Eeuo pipefail

main() {
  printf 'Running from %s\n' "$PWD"
}

main "$@"
```

| Setting | Purpose |
| --- | --- |
| `-E` | Preserves error traps in functions and substitutions. |
| `-e` | Exits in many, but not all, unhandled command-failure situations. |
| `-u` | Treats an unset variable expansion as an error. |
| `pipefail` | Makes a pipeline fail when any participating command fails. |

Strict mode reduces common mistakes but is not a substitute for explicit error handling and testing.

## Conditions and Loops

```bash
if [[ -f '<file>' ]]; then
  printf 'File exists\n'
fi

for stack in bootstrap identity platform; do
  printf 'Checking %s\n' "$stack"
done
```

## Parse JSON

If `jq` is installed:

```bash
jq '.' <file.json>
jq -r '.id' <file.json>
az account show --output json | jq -r '.id'
```

Do not write access tokens or secret-bearing JSON to an unprotected file.

## Check a Script Without Running It

**Read-only**

```bash
bash -n <script.sh>
```

If ShellCheck is installed:

```bash
shellcheck <script.sh>
```

## High-Risk Patterns

Review these patterns before use:

- `rm -rf` can recursively and permanently delete the wrong path.
- Unquoted variables and globs can expand to unexpected arguments.
- `eval` executes constructed text as shell code.
- `curl ... | bash` executes unreviewed remote content.
- `set -x` can print secrets and tokens to terminal or pipeline logs.
- Redirecting with `>` silently replaces an existing file.

Use an approved runbook when a shell command changes shared infrastructure, access, security controls, or production data.

## Official References

- [GNU Bash reference manual](https://www.gnu.org/software/bash/manual/)
- [Bash basic shell features](https://www.gnu.org/software/bash/manual/html_node/Basic-Shell-Features.html)
- [Bash built-in commands](https://www.gnu.org/software/bash/manual/html_node/Builtin-Index.html)
- [Bash `set` built-in](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)

[Command Cheat Sheets](README.md) | [Home](../Home.md)
