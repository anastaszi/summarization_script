import os
import openai
import click
import sys

@click.command()
@click.option('--file', type=click.Path(exists=True), required=True, help='Path to the input text file')
@click.option('--tokens', type=int, default=100, help='Number of tokens for the summary')
@click.option('--temperature', type=float, default=0.5, help='Sampling temperature for the summary')
@click.option('--model', type=str, default='text-davinci-002', help='Model used for text summarization')
def summarize(file, tokens, temperature, model):
    openai.api_key = os.getenv("OPENAI_API_KEY")
    
    if not openai.api_key:
        print("Error: OPENAI_API_KEY environment variable is not set. Please set it before running the script.")
        sys.exit(1)

    try:
        with open(file, "r") as f:
            text = f.read()
    except Exception as e:
        print(f"Error reading input file: {e}")
        sys.exit(1)

    try:    
        response = openai.Completion.create(
            engine=model,
            prompt=f"Please summarize the following text:\n{text}\n",
            max_tokens=tokens,
            n=1,
            stop=None,
            temperature=temperature,
            top_p=1,
            frequency_penalty=0,
            presence_penalty=0,
        )
    except Exception as e:
        print(f"Error calling OpenAI API: {e}")
        sys.exit(1)

    summary = response.choices[0].text.strip()
    print(summary)

if __name__ == '__main__':
    summarize()
