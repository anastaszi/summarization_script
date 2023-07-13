# Text Summarization with OpenAI API

This repository contains a Python script (`summarize.py`) and a Bash script (`run_summarize.sh`) that together provide a simple text summarization tool using the OpenAI API.

## Prerequisites

- Python 3.x
- An OpenAI API key
- Python packages: `openai` and `click`
- Paid OpenAI plan

## Installation

1. Clone the repository:

```
git clone https://github.com/anastaszi/text-summarization.git
cd text-summarization
```


2. Install the required Python packages:

```
pip install openai click
```

3. Set the `OPENAI_API_KEY` environment variable:

- For Linux/macOS:

  ```
  export OPENAI_API_KEY=your_api_key_here
  ```

- For Windows:

  ```
  set OPENAI_API_KEY=your_api_key_here
  ```

  Replace `your_api_key_here` with your actual OpenAI API key.

## Usage

### Using the Bash script

1. Make the Bash script executable:

```
chmod +x run_summarize.sh
```

2. Run the script:

```
./run_summarize.sh
```


Replace `input.txt` with the path to your input text file.

### Using the Python script directly

Run the Python script with the following command:

```
python summarize.py --file input.txt
```

Replace `input.txt` with the path to your input text file.

## Customizing the summarization

Both `run_summarize.sh` and `summarize.py` accept optional command-line arguments to customize the summarization:
- `-f or --file`: file path to a text file

- `-t or --tokens`: Number of tokens for the summary (default: 100)
- `-T or --temperature`: Sampling temperature for the summary (default: 0.5)
- `-m or --model`: Model used for text summarization (default: 'text-davinci-002')

| Option  run_summarize.sh        | Option  summarize.py  |Description                                                               | Default Value          | 
| -------------- | ------------------------------------------------------------------------- | ---------------------- | --------------------- |
| `-f` |  `--file`| File path to a text file. | N/A |
| `-t` | `--tokens` | Number of tokens for the summary. | `100` |
| `-T` | `--temperature` | Sampling temperature for the summary. | `0.5` |
| `-m` | `--model` | Model used for text summarization. | `'text-davinci-002'` |
| TBD `-o`| `--output` | Output file path for the summary. | `None`|



For example, to customize the number of tokens and temperature when using the Bash script, run:

```
./run_summarize.sh -f input.txt --t 150 -T 0.7
```

For the Python script, run:

```
python summarize.py --file input.txt --tokens 150 --temperature 0.7
```

## Troubleshooting

If you encounter any issues, please ensure that you have installed the required Python packages and set the `OPENAI_API_KEY` environment variable correctly. If you still experience issues, refer to the error messages displayed by the scripts for more information.

## Acknowlegment
README.md was generated with ChatGPT (GPT4) \
run_summarize.sh and summarize.py both were written by ChatGPT (GPT4) under my guidance
