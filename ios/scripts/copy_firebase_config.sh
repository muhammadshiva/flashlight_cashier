#!/bin/sh

# Get the environment from the build configuration (e.g., "Debug-dev" -> "dev")
ENVIRONMENT=""

if [[ $CONFIGURATION == *"dev"* ]]; then
  ENVIRONMENT="dev"
elif [[ $CONFIGURATION == *"staging"* ]]; then
  ENVIRONMENT="staging"
elif [[ $CONFIGURATION == *"production"* ]]; then
  ENVIRONMENT="production"
else
  # Default to dev if no specific match
  ENVIRONMENT="dev"
fi

echo "Copying Firebase config for environment: $ENVIRONMENT"

# Path to the specific GoogleService-Info.plist
PLIST_PATH="${PROJECT_DIR}/config/${ENVIRONMENT}/GoogleService-Info.plist"
# Destination path inside the built app set by Xcode
DESTINATION="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

# Check if source exists
if [ ! -f "$PLIST_PATH" ]; then
    echo "error: GoogleService-Info.plist not found in ${PLIST_PATH}"
    exit 1
fi

# Copy the file to the app bundle
cp "${PLIST_PATH}" "${DESTINATION}"

echo "Successfully copied ${PLIST_PATH} to ${DESTINATION}"
