from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect_gcp.credentials import GcpCredentials
from prefect_gcp.bigquery import bigquery_create_table
from prefect.filesystems import LocalFileSystem
from google.cloud import bigquery

@task()
def fetch(dataset_url: str) -> pd.DataFrame:
    df = pd.read_csv(dataset_url, encoding = 'utf-8', sep = '\t', low_memory=False)
    return df

@task
def clean(df: pd.DataFrame) -> pd.DataFrame:
    if set(["catch"]).issubset(df.columns):
      df["catch"] = pd.to_datetime(df["catch"])
    if set(["creation"]).issubset(df.columns):
      df["creation"] = pd.to_datetime(df["creation"])
    return df

@task
def write_local(df: pd.DataFrame, dataset_file: str) -> None:
    path = Path(f"data/{dataset_file}.parquet")
    path.parent.mkdir(parents=True, exist_ok=True)
    df.to_parquet(path, compression="gzip")


@task
def write_gcs(filename: str) -> None:
    gcs_block = GcsBucket.load("smm-gcs")
    gcs_block.upload_from_path(from_path=Path(f"data/{filename}.parquet"), to_path=Path(f"{filename}.parquet"))
    

def create_ext_table(tablename: str) -> None:
    ext_tablename = f"{tablename.replace('-','_')}_ext"     
    gcs_cred = GcpCredentials.load("gc-creds")
    ext_config = bigquery.ExternalConfig('PARQUET')
    ext_config.source_uris = [f"gs://data_lake_bucket_smm-analyze-prj/{tablename}.parquet"]
    bigquery_create_table(
      dataset = "smm_raw_dataset", 
      table = ext_tablename,
      gcp_credentials = gcs_cred,
      location = "europe-west1",
      external_config = ext_config
    )

@flow(name="01_extract_load")
def extract_and_load() -> None:
    tablesets: list[str]= [ "courses", "likes", "players", "plays", "records", "clears", "course-meta"]
    for tablename in tablesets:
        tablename_url = f"https://github.com/svetlanakononova/smm-analyze/releases/download/datafiles/{tablename}.csv.gz"
        df = fetch(tablename_url)
        df_clean = clean(df)
        write_local(df_clean, tablename)
        write_gcs(tablename)
        create_ext_table(tablename)

if __name__ == "__main__":
    extract_and_load()


    



