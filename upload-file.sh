#!/bin/bash


S3_BUCKET_NAME="s3://007file-upload-bucket/"
MAX_FILE_SIZE_BYTES=104857600  # 100 MB limit

prompt_user(){

  echo -n "Enter File Paths (separated by space): " && read -r filepaths
  IFS=' ' read -ra  filepath_array <<< "$filepaths"

  # Loop through each filepath to extract and store basenames
  for filepath in "${filepath_array[@]}"; do
    filename=$(basename "$filepath")
    filename_array+=("$filename")

    echo "$filename"
  done

}

print_error(){

  local message="$1"
  echo "Error: $message"

}


file_exists(){

  local filepath="$1"
  local filename
  filename=$(basename "$filepath")

  if [ -f "$filepath" ]; then
    echo "File $filename exists locally"
    return
  else
    print_error "File does not exist. Please enter a valid file path."
    prompt_user
  fi

}

check_filesize(){

  local filepath="$1"

  local filename
  filename=$(basename "$filepath")

  local file_size
  file_size=$(wc -c "$filepath" | awk '{print $1}')


  # Check if the file size exceeds the limit
  if [ "$file_size" -gt "$MAX_FILE_SIZE_BYTES" ]; then
    print_error "File size exceeds the limit. Maximum allowed size is 100 MB."
    # prompt_user
  else
    echo "Acceptable file size"
  fi
}


s3_file_exists() {
  local filepath="$1"
  
  local filename
  filename=$(basename "$filepath")
  local bucket_name=${S3_BUCKET_NAME#s3://}
  bucket_name=${bucket_name%/}  # Remove trailing slash if present

  # Debugging output
  echo "Checking in bucket: $bucket_name"
  echo "Checking for file: $filename"

  if aws s3api head-object --bucket "$bucket_name" --key "$filename" &> /dev/null; then
    echo "File already exists in S3: $filename"
    return 0 # File exists
  else
    local status=$?
    echo "AWS CLI returned status $status"
    echo "File does not exist in S3: $filename"
    return 1 # File does not exist
  fi
}



handleupload (){

  prompt_user

  for filepath in "${filepath_array[@]}"; do

    if file_exists "$filepath" && check_filesize "$filepath"; then

      if ! s3_file_exists "$filepath"; then
        aws s3 cp "$filepath" "$S3_BUCKET_NAME" >  upload-success.txt
        echo "Uploading file"
      else
        echo "Skipping upload..."
      fi
      
    fi
  done

}


handleupload
