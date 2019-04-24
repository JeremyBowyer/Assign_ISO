import pandas as pd
import re
import numpy as np
isoCodes = pd.read_csv('https://raw.githubusercontent.com/JeremyBowyer/Assign_ISO/master/ISO%20Country%20Codes.csv')

def assign_iso(df, countryCol):

    # Find code for each possible country name in ISO code DF
    nameCols = [col for col in isoCodes.columns if re.compile("Name").match(col)]
    for col in nameCols:
        i = int(col.split("Name.")[1])
        df = df.merge(isoCodes[[col, "Code"]], how="left", left_on=countryCol, right_on=col, suffixes=["__"+str(i-1), "__"+str(i)])
        df.drop(col, axis=1, inplace=True)

    # Find first valid match, throw out all others
    codeCols = [col for col in df.columns if re.compile("Code__").match(col)]
    df['ISO'] = df[codeCols].apply(lambda row: next((val for val in list(row) if val == val), np.nan), axis=1)

    # Drop other code columns
    for col in codeCols:
        df.drop(col, axis=1, inplace=True)
        
    return df