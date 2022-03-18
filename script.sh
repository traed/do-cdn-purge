#!/bin/sh

if [[ -z "${PLUGIN_TOKEN}" || -z "${PLUGIN_ORIGIN}" || -z "${PLUGIN_PATTERN}" ]]; then
	exit 1
fi

ENDPOINTS=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${PLUGIN_TOKEN}" "https://api.digitalocean.com/v2/cdn/endpoints")

if [ ! $ENDPOINTS ]; then
	echo "Could not find any endpoints. Check that your token and origin parameteras are valid."
	exit 1
fi

for row in $(echo "${ENDPOINTS}" | jq -c '.endpoints[] | @base64'); do
	_jq() {
		echo ${row} | base64 -d | jq -r ${1}
	}
	if [ $(_jq '.origin') == "${PLUGIN_ORIGIN}" ]; then
		ID=$(_jq '.id')
		break
	fi
done

if [ $ID ]; then
	STATUS=$(curl -X DELETE -H "Content-Type: application/json" \
		-H "Authorization: Bearer ${PLUGIN_TOKEN}" \
		-d "{\"files\": [\"${PLUGIN_PATTERN}\"]}" \
		--write-out '%{http_code}' --silent --output /dev/null \
		"https://api.digitalocean.com/v2/cdn/endpoints/${ID}/cache")
fi

if [[ "${STATUS}" -gt "299" ]]; then
	echo "Recieved response with invalid status ${STATUS}"
	exit 2
fi

exit 0