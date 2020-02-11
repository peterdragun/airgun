#!/usr/bin/env bash
set -euo pipefail
array=("entities views")
for test_suite in browser entities fixtures navigation session settings views widgets; do
    cat >"docs/api/airgun.${test_suite}.rst" <<EOF
:mod:\`airgun.${test_suite}\`
$(printf %$(( 14 + ${#test_suite} ))s | tr ' ' =)

.. automodule:: airgun.${test_suite}
    :members:
EOF
    if [[ " ${array[@]} " =~ " ${test_suite} " ]]; then
        find "airgun/${test_suite}" -type f -not -path "*__*" | sort | while read -r file_name; do
            module_name="${file_name%.py}"
            module_name="${module_name//\//.}"

            cat >>"docs/api/airgun.${test_suite}.rst" <<EOF

:mod:\`${module_name}\`
$(printf %$(( 7 + ${#module_name} ))s | tr ' ' -)

.. automodule:: ${module_name}
   :members:
EOF
        done
    fi
done
