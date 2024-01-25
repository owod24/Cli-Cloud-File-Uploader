#!/bin/bash
S3_BUCKET_NAME="s3://007file-upload-bucket/"
MAX_FILE_SIZE_BYTES=104857600  # 100 MB limit
prompt_user(){
  echo -n "Enter File Path: " && read -r filepath
  filename=$(basename "$filepath")
}

print_error(){
  local message="$1"
  echo "Error: $message"
}


file_exists(){
  prompt_user
  if [ -f "$filepath" ]; then
    echo "File $filename exists locally"
    return
  else
    print_error "File does not exist. Please enter a valid file path."
    prompt_user
  fi

}

check_filesize(){
  # Get file size
  file_size=$( wc -c "$filepath" | awk '{print $1}')
  # Check if the file size exceeds the limit
  if [ "$file_size" -gt "$MAX_FILE_SIZE_BYTES" ]; then
    print_error "File size exceeds the limit. Maximum allowed size is 100 MB."
    prompt_user
  else
    echo "Acceptable file size"
  fi
}

validate_upload_file() {
  file_exists
  check_filesize
}

s3_file_exists() {
  
  aws s3 ls "$S3_BUCKET_NAME/$filepath" > output.txt;

  if  grep -q "$filepath" output.txt; then
    echo "File already exists in S3: $filepath"
    return 0 #Success (file exists) 
  else
    echo "File does not exist in S3: $filepath"
    return 1 #Error (file does not exist)
  fi
}


handleupload (){
  validate_upload_file 

  s3_file_exists
  return_code=$?

  if [ $return_code -eq 0 ]; then
    echo "Skipping upload. File already exists"
  else
    # Add success messages for completed operations
    aws s3 cp "$filepath" "$S3_BUCKET_NAME" >  upload-success.txt
    if grep -q "Completed" upload-success.txt; then
      echo "Upload Successful"
    fi
  fi
}



handleupload
