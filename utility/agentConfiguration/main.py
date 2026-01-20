from azure.identity import AzureCliCredential
from azure.ai.projects import AIProjectClient
from dotenv import load_dotenv
import os

def main():

    load_dotenv(override=True)

    project = AIProjectClient(
        endpoint=os.getenv('AZURE_AI_FOUNDRY_ENDPOINT'),
        credential=AzureCliCredential()
    )


if __name__ == "__main__":
    main()
