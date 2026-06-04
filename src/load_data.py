from pathlib import Path
import pandas as pd 
from src.preprocessing import rename_brazil_columns



DATA_DIR = Path(__file__).resolve().parents[1] / "data" / "processed"


def load_wisconsin():
    """ Load the cleaned Wisconsin dataset:
    returns:
    tuple[pd.DataFrame, str]: The full dataframe and the target column name.


    """
    path = DATA_DIR / "wisconsin_clean.csv"
    df = pd.read_csv(path)
    target_col = "Diagnosis"
    return df, target_col 

def load_brazil(sample_size = None, random_state = 42, rename_cols = True, drop_high_missing=True):
    """Load the Brazil modeling dataset, optionally sampling rows.

    Args:
        sample_size: Number of rows to sample. If None, load all rows.
        random_state: Random seed used when sampling.

    Returns:
        tuple[pd.DataFrame, str]: The dataframe and the target column name.
    """
   
    path = DATA_DIR / "brazil_modeling.csv"
    df = pd.read_csv(path)

    if rename_cols:
        df=rename_brazil_columns(df)
        target_col = "deceased"
    else:
        target_col = "target_deceased"

    if drop_high_missing:
        drop_col = "diagnosis_year" if rename_cols else "Diag_Year"
        df = df.drop(columns=[drop_col])

    if sample_size is not None:
        df = df.sample(n=sample_size, random_state=random_state)
    
  

    return df, target_col

def split_X_y(df, target_col):
    X= df.drop(columns=[target_col])
    y = df[target_col]
    return X, y



