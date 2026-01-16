from dotenv import load_dotenv
from azure.search.documents.indexes.aio import SearchIndexClient
from azure.core.credentials import AzureKeyCredential
from azure.search.documents.indexes.models import (
    SearchField,
    VectorSearch,
    HnswAlgorithmConfiguration,
    VectorSearchProfile,
    SearchIndex,    
    SearchFieldDataType
)
import os

load_dotenv(override=True)

search_endpoint = os.getenv('SEARCH_ENDPOINT')
search_api_key = os.getenv('SEARCH_API_KEY')

