from prefect import flow, task
from prefect_dbt.cli.commands import trigger_dbt_cli_command
from prefect_dbt.cli import DbtCliProfile
import os

def run() -> None:
    dbt_profile = DbtCliProfile.load("dbt-profile")
    trigger_dbt_cli_command(
        command = "dbt run",
        profiles_dir = f"{os.environ['HOME']}/.dbt",
        project_dir = f"{os.environ['HOME']}/smm-analyze/dbt/smm_analyze",
        overwrite_profiles = True,
        dbt_cli_profile = dbt_profile
    )


@flow(name="02_dbt_run")
def dbt_run() -> None:
    run()

if __name__ == "__main__":
    dbt_run()


    



