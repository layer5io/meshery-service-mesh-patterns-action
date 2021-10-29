#!/usr/bin/env bash

SCRIPT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}" || realpath "${BASH_SOURCE[0]}")")


main() {
	local pattern_filename=
	local pattern_name=

	parse_command_line "$@"

	if [ -z "$pattern_name" ]
	then

		mesheryctl pattern apply --file $GITHUB_WORKSPACE/.github/$pattern_filename

	else

            docker network connect bridge meshery_meshery_1
			docker network connect minikube meshery_meshery_1
			docker network connect bridge meshery_meshery-"$shortName"_1
			docker network connect minikube meshery_meshery-"$shortName"_1

			mesheryctl system config minikube -t ~/auth.json

		mesheryctl pattern apply $pattern_name 

	fi
}

parse_command_line() {
	while :
	do
		case "${1:-}" in
			--pattern-filename)
				if [[ -n "${2:-}" ]]; then
					pattern_filename=$2
					shift
				else
					echo "ERROR: '--pattern-filename' cannot be empty." >&2
					exit 1
				fi
				;;
			--pattern-name)
				if [[ -n "${2:-}" ]]; then
					pattern_name=$2
					shift
				else
					echo "ERROR: '--pattern-name' cannot be empty." >&2
					exit 1
				fi
				;;
			*)
				break
				;;
		esac
		shift
	done
}

main "$@"