#!/bin/bash

table_name="ChatMessage-7j3ypcju3nf37othmvhtknfvji-production"
output_json="output.json"
output_csv="output.csv"

# Initial scan
aws dynamodb scan \
  --table-name "$table_name" \
  --projection-expression "rfqId, message" \
  --max-items 1000 \
  --output json > "$output_json"

# Extract and format RFQ ID and MESSAGE into CSV file with double quotes
jq -r '.Items[] | select(has("rfqId") and has("message") and (.rfqId.S | length > 0) and (.message.S | length > 0)) | "\"\(.rfqId.S)\", \"\(.message.S | gsub("\n"; "\\n"))\""' "$output_json" > "$output_csv"

# Loop to paginate through results
while [ $(jq -r '.LastEvaluatedKey' "$output_json") != "null" ]; do
  starting_token=$(jq -r '.LastEvaluatedKey' "$output_json")
  
  aws dynamodb scan \
    --table-name "$table_name" \
    --projection-expression "rfqId, message" \
    --max-items 1000 \
    --starting-token "$starting_token" \
    --output json >> "$output_json"
  
  # Extract and format RFQ ID and MESSAGE into CSV file with double quotes
  jq -r '.Items[] | select(has("rfqId") and has("message") and (.rfqId.S | length > 0) and (.message.S | length > 0)) | "\"\(.rfqId.S)\", \"\(.message.S | gsub("\n"; "\\n"))\""' "$output_json" >> "$output_csv"
done

# Remove LastEvaluatedKey from the final JSON output
jq 'del(.LastEvaluatedKey)' "$output_json" > "$output_json"
rm "$output_json"

echo "Finished retrieving data. Results stored in $output_csv"
