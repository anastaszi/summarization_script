#!/bin/bash

echo "Hello there!"

# Check if OPENAI_API_KEY is set, if not, prompt user to enter it
if [ -z "$OPENAI_API_KEY" ]; then
    echo ""
    echo "======================"
    echo "|> OPENAI_API_KEY environment variable is not yet set."
    echo "|> Please come back as you set it."
    echo "======================"
    echo ""
    echo "For Mac/Linux:"
    echo "> export OPENAI_API_KEY=your_api_key_here"
     echo "______________"
    echo "For Windows:"
    echo "> set OPENAI_API_KEY=your_api_key_here"
    echo "______________"
    exit 1
fi

# Install dependencies if not already installed
if ! command -v pip3 &> /dev/null; then
    echo "pip3 not found. Please install pip before proceeding."
    exit 1
fi

if ! pip3 freeze | grep -q "openai"; then
    echo "Installing openai package..."
    pip3 install openai
fi

if ! pip3 freeze | grep -q "click"; then
    echo "Installing click package..."
    pip3 install click
fi

# Default settings
TOKENS="500"
TEMPERATURE="0.5"
MODEL="text-davinci-003"

# Parse command line arguments for input file, tokens, temperature, and model
UPDATE_SETTINGS=""
while getopts ":f:t:T:m:" opt; do
  case $opt in
    f)
      INPUT_FILE="$OPTARG"
      ;;
    t)
      TOKENS="$OPTARG"
      UPDATE_SETTINGS="n"
      ;;
    T)
      TEMPERATURE="$OPTARG"
      UPDATE_SETTINGS="n"
      ;;
    m)
      MODEL="$OPTARG"
      UPDATE_SETTINGS="n"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done



# Prompt user for input file if not provided
if [ -z "$INPUT_FILE" ]; then
    echo "Please enter the path to the input text file:"
    read -r INPUT_FILE
fi

# Check if the provided file is a valid text file
if [ ! -f "$INPUT_FILE" ] || [[ ! "$INPUT_FILE" == *.txt ]]; then
    echo "Invalid file. Please provide a valid text file."
    exit 1
fi

if [ "$UPDATE_SETTINGS" = "" ]; then
    # Ask if user wants to update default settingS
        echo "Do you want to update the settings (tokens, temperature, model)? (y/n)"
        read -r UPDATE_SETTINGS
    while [ "$UPDATE_SETTINGS" = "y" ]; do
        echo "Which setting do you want to update? (Enter the numbers separated by space)"
        echo "1. Tokens (current: ${TOKENS})"
        echo "2. Temperature (current: ${TEMPERATURE})"
        echo "3. Model (current: ${MODEL})"
        read -ra SETTINGS_TO_UPDATE

        for setting in "${SETTINGS_TO_UPDATE[@]}"; do
            case $setting in
                1)
                    echo "Enter the number of tokens (1-2000):"
                    read -r TOKENS
                    if ! [[ $TOKENS =~ ^[1-9][1-9][0-9]{0,2}$ ]] || ((TOKENS > 2001)); then
                        echo "Invalid input. Number of tokens must be between 1 and 2000."
                        exit 1
                    fi
                    ;;
                2)
                    echo "Enter the temperature (0-1):"
                    read -r TEMPERATURE
                    if ! [[ $TEMPERATURE =~ ^[0-1](\.[0-9]+)?$ ]]; then
                        echo "Invalid input. Temperature must be a number between 0 and 1."
                        exit 1
                    fi
                    ;;
                3)
                    echo "Choose a model from the list:"
                    echo "1. text-davinci-003"
                    echo "2. text-curie-002"
                    echo "3. text-babbage-002"
                    echo "4. text-ada-002"
                    read -r MODEL_SELECTION

                    case $MODEL_SELECTION in
                        1) MODEL="text-davinci-002" ;;
                        2) MODEL="text-curie-002" ;;
                        3) MODEL="text-babbage-002" ;;
                        4) MODEL="text-ada-002" ;;
                        *)
                            echo "Invalid selection. Please choose a valid model number."
                            exit 1
                            ;;
                    esac
                    ;;
            esac
        done
        echo "Do you want to update more settings (tokens, temperature, model)? (y/n)"
        read -r UPDATE_SETTINGS
    done
fi

# Run the Python script
if [ -f "summarize.py" ]; then
   python3 summarize.py --file "$INPUT_FILE" --tokens "$TOKENS" --temperature "$TEMPERATURE" --model "$MODEL"
else
    echo "summarize.py not found. Please make sure the script is in the same directory."
fi
