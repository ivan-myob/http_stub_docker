#!/usr/bin/env bash

set -e

if [ "$#" -lt 2 ]; then
  echo "usage: $(basename "$0") NAME TAG [TAGS...]" && exit 1
fi

app_name="$1"
app_tags="${@:2}"

eval $(aws ecr get-login --no-include-email --region "$AWS_REGION")
IFS=' ' read -ra tags <<< "$app_tags"
for tag in "${tags[@]}"; do
  image_tag="$AWS_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$app_name:$tag"
  docker tag "$app_name" "$image_tag"
  docker push "$image_tag"
done
