#!/usr/bin/env bash

# shellcheck shell=bash

# ``````````````````````````````````````````````````````````````````````````````
# Function name: nse_vuln-scanners()
#
# Description:
#   NSE Vulnerability Scanners Module.
#
# Usage:
#   nse_vuln-scanners
#
# Examples:
#   nse_vuln-scanners
#

function nse_vuln-scanners() {

  # shellcheck disable=SC2034
  local _FUNCTION_ID="nse_vuln-scanners"
  local _STATE=0

  # User variables:
  # - module_name: store module name
  # - module_args: store module arguments

  export _module_show=
  export _module_help=
  export _module_opts=
  export _module_commands=

  # shellcheck disable=SC2034
  _module_variables=()

  # shellcheck disable=SC2034
  author="trimstray"
  contact="trimstray@gmail.com"
  version="1.0"
  description="NSE Vulnerability Scanners Module"

  # shellcheck disable=SC2034,SC2154
  _module_cfg="${_modules}/${module_name}.cfg"

  touch "$_module_cfg"

  # shellcheck disable=SC2034,SC2154
  _module_help=$(printf "%s" "
  Module: ${module_name}

    Description
    -----------

      NSE Vulnerability Scanners Module.

    Commands
    --------

      help    <module>                display module or NSE help
      show    <key>                   display module or profile info
      config  <key>                   show module configuration
      set     <key>                   set module variable value
      use     <module>                reuse module (changed env)
      pushd   <key>|init|show|flush   command line commands stack
      search  <key>                   search key in all commands
      init    <alias|id>              run profile

      Options:

        <key>                         key value
        <value>                       profile alias or id

")

  # shellcheck disable=SC2154
  if [[ "$_mstate" -eq 0 ]] ; then

    if [[ -e "$_module_cfg" ]] && [[ -s "$_module_cfg" ]] ; then

      # shellcheck disable=SC1090
      source "$_module_cfg"

    else

      # shellcheck disable=SC2034
      _module_variables=()

      if [[ "${#_module_variables[@]}" -ne 0 ]] ; then

        printf "_module_variables=(\"%s\")\\n" "${_module_variables[@]}" > "$_module_cfg"

      fi

      _mstate=1

    fi

  else

    # shellcheck disable=SC1090
    source "$_module_cfg"

  fi

  # In the given commands you can use variables from the CLI config
  # command or the etc/main.cfg file.

  # shellcheck disable=SC2034
  _module_commands=(\
  #
  "https://nmap.org/nsedoc/scripts/nessus-brute.html;\
  ;nessus-brute;--script=nessus-brute" \
  #
  "https://nmap.org/nsedoc/scripts/nessus-xmlrpc-brute.html;\
  ;nessus-xmlrpc-brute;--script=nessus-xmlrpc-brute" \
  #
  "https://nmap.org/nsedoc/scripts/nexpose-brute.html;\
  ;nexpose-brute;--script=nexpose-brute" \
  #
  "https://nmap.org/nsedoc/scripts/omp2-brute.html;\
  ;omp2-brute;--script=omp2-brute" \
  #
  "https://nmap.org/nsedoc/scripts/omp2-enum-targets.html;\
  ;omp2-enum-targets;--script=omp2-enum-targets" \
  #
  "https://nmap.org/nsedoc/scripts/openvas-otp-brute.html;\
  ;openvas-otp-brute;--script=openvas-otp-brute" \
  #
  "https://nmap.org/nsedoc/scripts/shodan-api.html;\
  ;shodan-api;--script=shodan-api" \
  )

  # shellcheck disable=SC2034,SC2154
  _module_show=(\
      "${module_name}" \
      "${version}" \
      "${#_module_commands[@]}" \
      "${author}" \
      "${contact}" \
      "${description}" \
      )

  # shellcheck disable=SC2034
  export _module_opts=(\
  "$_module_help")

  return $_STATE

}
