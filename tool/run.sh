cd ../
source .env
export $(cut -d= -f1 .env)

flutter run \
--dart-define=NEWS_BASE_URL="$NEWS_BASE_URL" \
--dart-define=NEWS_API_KEY="$NEWS_API_KEY"
