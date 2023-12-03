cd ../
source .env
export $(cut -d= -f1 .env)

flutter build apk --split-per-abi \
--dart-define=NEWS_API_KEY="$NEWS_API_KEY" \
--dart-define=NEWS_BASE_URL="$NEWS_BASE_URL"