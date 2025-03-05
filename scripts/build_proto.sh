#!/bin/bash

# Clean up previously generated files before regenerating if they exist
if [ -d "./src/generated" ]; then
  echo "Cleaning previously generated files..."
  rm -rf ./src/generated
fi

# Create the output directory if it doesn't exist
if [ ! -d "./src/generated" ]; then
  echo "Creating output directory ./src/generated"
  mkdir -p ./src/generated
fi

echo "🚀 Generating TypeScript code from .proto files..."

# Iterate over each proto file
for proto_file in proto/*.proto; do
  # Extract filename without extension (e.g., "auth" from "auth.proto")
  filename=$(basename "$proto_file" .proto)
  
  # Create directory for this proto
  mkdir -p "./src/generated/$filename"
    
  # Run protoc for this specific file
  npx grpc_tools_node_protoc \
    --proto_path=./proto \
    --plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
    --plugin=protoc-gen-grpc=./node_modules/.bin/grpc_tools_node_protoc_plugin \
    --js_out=import_style=commonjs,binary:./src/generated/$filename \
    --ts_out=grpc_js:./src/generated/$filename \
    --grpc_out=grpc_js:./src/generated/$filename \
    "$proto_file"
done


# Check if any errors occurred
if [ $? -eq 0 ]; then
  echo "✅ All .proto files compiled successfully!"
else
  echo "❌ Error: Failed to compile .proto files!" >&2
  exit 1
fi