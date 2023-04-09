from prefect_gcp.credentials import GcpCredentials
from prefect_gcp.cloud_storage import GcsBucket
from prefect_dbt.cli.configs import BigQueryTargetConfigs
from prefect_dbt.cli import DbtCliProfile


service_account_file = "~/.google/google_creds.json"
creds = GcpCredentials(
        service_account_file=service_account_file
    )
creds.save("gc-creds", overwrite=True)

bucket = GcsBucket(bucket="data_lake_bucket_smm-analyze-prj", gcp_credentials=creds)
bucket.save("smm-gcs", overwrite=True)

dbt_configs = BigQueryTargetConfigs(
    schema="smm",  
    credentials=creds,
    project="smm-analyze-prj",
    location="europe-west1"
)

dbt_configs.save("dbt-gcc", overwrite=True)

dbt_cli_profile = DbtCliProfile(
    name="smm_analyze",
    target="dev",
    target_configs=dbt_configs
)

dbt_cli_profile.save("dbt-profile", overwrite=True)

