# NFT_analysis

### TLDR
A regression analysis of NFT prices from the moonstream.to data collection on NFTs. Previous transactions are the driving feature indicating the value of an NFT and visual features and selling circles are key to NFTs increasing in price.

### Introduction 
The introduction and excitement around Non-Fungible Tokens, NFTs, has raised both extreme excitement and extreme skepticism. The key innovation surrounding NFTs is the ability for an individual to own a piece of digital material. This is possible due to innovations in technology around blockchains and smart contracts. The recent activity in regard to NFTs has been performed on the Ethereum blockchain and all of the data for the study is collected from Ethereum based NFT activity. There is some worry that analyzing only a single blockchain could results in bias in the value as NFT has fees of around $40 per NFT creating biasing the value of the NFTs to be higher than other blockchains, such as Solana. The current price of NFTs are qualitatively assumed to be a function of their exclusivity, visual characteristics, length of existence with older NFTs being viewed as being more valuable, and other characteristics such as network effects or utility. This study and the associated repo looks to analyze the impacts of the characteristics captured by the simple records of the NFTs, their trading patterns, and their minting patterns.

### Data Overview
- The original data sources that used was a scraping of all NFT transactions on the Ethereum blockchain from April 1, 2021 to September 25, 2021 from [Kaggle](https://www.kaggle.com/datasets/simiotic/ethereum-nfts)
- Most of the data is skewed to the right. This is addressed in the modeling by transform the data to make it more normally distributed
- The data recorded information for all copies of NFTs so I aggregated all of the data for the specific unique NFT address therefore all features I used were derived features of the data set 
- Because this was a massive dataset of 7 million different events, I chose a randomly sampled the data and choose a subset of 75 NFTs total which was equivalent to over 1 million different events

### Modeling Overview and Decisions
#### Exploratory Data Analysis
- Box Plots, Histograms, Correlation Plots
- Saw High Skewness of data, Influential and high value outliers
- Scaled the data down as the numbers were so big
#### Linear Model
- Multiple Linear Regression
- Residual Analysis and Model Assumption Analysis
- Leaps Model Selection with Adjusted R squared
#### WLS, Ridge Regression, and Robust Regression
- Justification: Ridge Trace Plots, Heteroskedasticity, Multicollinearity
- Assessed Model Performance 
- Similarities and Differences
#### Random Forest
- Reasoning: Non linear interactions, skewed and non-normal data
- Parameters choice was done by using the basic setup offered by R
- Model Performance and comparison to the others using Mean Square Error (MSE)
#### Model Edits
-Exclusion of Transfer Value as an explanatory variable
-Exclusion of Outlier Values slightly improved linear models but reduced Random Forest model performance
-Log Transforms
#### Evaluation Metrics
- Mean Square Error
- What is it: sum of the squared difference between actual and predicted values divided by the number of observations
- Training and test set: I set this up with a training and testset so there was more equivalent comparison between the models as the Random Forest model needs to see new data to have the MSE stat
- Why use it: Random forest isn’t a linear model
- This requires the splitting of data into training sets and test sets

### Conclusion and Future Work
To conclude here are some interesting takeaways and potential directions in which future work could be taken

#### Model Comparison
Robust Regression was the best performing model, Linear assumptions weren’t met. More data transformation could lead to data which met linear assumptions

#### Feature Importance
Over Importance of Transfer Value in prediction ability. It would be interesting to collect more variables and see if there is a model that could have equal explanatory power to those with Transfer value

#### Variable Transformation
Improves the data but zero inflation leads to limited benefits. I used log but other methods could have less impact front he zeros in the data and therefore have even lower skew values 

#### Random Forest Regression
Difference in parametric and non parametric models could be further explored and more data analyzed to see the performance of the Random forest on 1000 -10000 observations

### Resources 
- [Random Forest Information](https://levelup.gitconnected.com/random-forest-regression-209c0f354c84)
- [NFT statistics](https://influencermarketinghub.com/nfts-statistics/)
- [Top NFT Sales](https://www.dexerto.com/tech/top-10-most-expensive-nfts-ever-sold-1670505/)





