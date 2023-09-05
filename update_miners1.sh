#!/bin/bash

# Loop through all folders with -c11 in the name
for folder in $(find . -type d -name "*-c11"); do
  cd $folder

  # Extract the image name from deploy.yaml
  full_image_name=$(grep 'image:' deploy.yaml | awk '{print $2}')

  # Separate the image name from the tag
  image_name=$(echo $full_image_name | awk -F ':' '{print $1}')

  # Get the latest tag using curl and jq
  latest_tag=$(curl -s "https://registry.hub.docker.com/v2/repositories/$image_name/tags?page_size=100" | jq -r '.results[0].name')

  # Increment the latest tag by 1
  new_tag=$((latest_tag + 1))

  # Build the new Docker image
  docker build -t $image_name:$new_tag . --no-cache

  # Push the new Docker image
  if docker push $image_name:$new_tag; then
    # Update the deploy.yaml with the new tag if the push is successful
    #sed -i "s/$full_image_name/$image_name:$new_tag/g" deploy.yaml
    sed -i "s|$full_image_name|$image_name:$new_tag|g" deploy.yaml

  fi
  # Move back to the original directory
  cd ..
done
