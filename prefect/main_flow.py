from prefect import flow, task
from extract_load import extract_and_load
from dbt import dbt_run


@flow(name="mainflow")
def mainflow () -> None:
    extract_and_load()
    dbt_run()    

if __name__ == "__main__":
    mainflow()
