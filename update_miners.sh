#!/bin/bash

# Loop through all folders with -c11 in the name
for folder in $(find . -type d -name "*-c11"); do
  echo "Processing folder: $folder"

  # Change directory
  cd $folder || { echo "Failed to cd into $folder"; continue; }

  # Extract the image name from deploy.yaml
  full_image_name=$(grep 'image:' deploy.yaml | awk '{print $2}') || { echo "Failed to get image name from deploy.yaml"; cd ..; continue; }

  # Separate the image name from the tag
  image_name=$(echo $full_image_name | awk -F ':' '{print $1}')

  # Get the latest tag using curl and jq
  latest_tag=$(curl -s "https://registry.hub.docker.com/v2/repositories/$image_name/tags?page_size=100" | jq -r '.results[0].name') || { echo "Failed to get latest tag"; cd ..; continue; }

  # Check if latest_tag is a number
  if ! [[ $latest_tag =~ ^[0-9]+$ ]]; then
    echo "Latest tag is not a number: $latest_tag"
    cd ..
    continue
  fi

  # Increment the latest tag by 1
  new_tag=$((latest_tag + 1))

  # Build the new Docker image
  docker build -t $image_name:$new_tag . --no-cache || { echo "Failed to build Docker image"; cd ..; continue; }

  # Try to push the new Docker image up to 4 times
  for i in {1..4}; do
    if docker push $image_name:$new_tag; then
      # Update the deploy.yaml with the new tag if the push is successful
      sed -i "s|$full_image_name|$image_name:$new_tag|g" deploy.yaml || { echo "Failed to update deploy.yaml"; cd ..; continue; }
      break  # Break the loop if push is successful
    else
      echo "Failed to push Docker image, attempt $i"
      sleep 5  # Wait for 5 seconds before retrying
    fi
  done

  # If push failed 4 times, log it
  if [ "$i" -eq 4 ]; then
    echo "Failed to push Docker image after 4 attempts. Skipping this folder."
  fi
  
  # Move back to the original directory
  cd ..
done
