
### title: "math_340_final_project_NFTs"
### author: "Robert Alward"
### date: "11/20/2021"

library(tidyverse)

mid_mints <- read.csv("valid_mints_df.csv", header = T)
mid_value <- read.csv("valid_value_df.csv", header = T)
mid_owner <- read.csv("valid_owner_df.csv", header = T)
mid_trans <- read.csv("valid_trans_df.csv", header = T) 

# average final value of NFT
avg_value_df <- mid_value %>% 
  group_by(nft_address)%>%
  summarize(current_mean_val = mean(market_value))
avg_value_df


# Mean mint value of NFT
mint_mean_value_df <- mid_mints %>% 
  group_by(nft_address)%>%
  summarize(mint_mean_val = mean(transaction_value))
mint_mean_value_df


# Max mint transaction value of NFT
mint_min_value_df <- mid_mints %>% 
  group_by(nft_address)%>%
  summarize(mint_min_val = min(transaction_value))
mint_min_value_df

# Max mint transaction value of NFT
mint_max_value_df <- mid_mints %>% 
  group_by(nft_address)%>%
  summarize(mint_max_val = max(transaction_value))
mint_max_value_df


# Count of NFTs per unique address
count_nfts_df <- mid_value %>% 
  group_by(nft_address)%>%
  tally()
names(count_nfts_df)[2]<-"count_nfts"
count_nfts_df

# Count of Different owners per unique NFT address
unique_owner_df <- mid_owner %>%                              # Applying group_by & summarise
  group_by(nft_address) %>%
  summarise(count = n_distinct(owner))
names(unique_owner_df)[2]<-"count_unique_owners"
unique_owner_df


# Count of number of transactions per unique NFT address
count_transfers_df <- mid_trans %>%                              
  group_by(nft_address) %>%
  tally()
names(count_transfers_df)[2]<-"count_transfers"
count_transfers_df

# Count of number of unique owners of transactions per unique NFT address
count_unique_transfers_df <- mid_trans %>%                              
  group_by(nft_address) %>%
  summarise(count_unique_trans = n_distinct(to_address))
count_unique_transfers_df

# Average price of transaction per unique NFT address
mean_transfer_value_df <- mid_trans %>%                              
  group_by(nft_address) %>%
  summarize(mean_trans_val = mean(transaction_value))
mean_transfer_value_df


# First Time of minting an NFT
first_mint_df <- mid_mints %>% 
  group_by(nft_address)%>%
  summarize(first_time = min(timestamp))
first_mint_df$first_time_hr <- as.POSIXct(as.numeric(first_mint_df$first_time), origin = "1970-01-01")
first_mint_df


# Last transfer of NFT
last_trans_df <- mid_trans %>% 
  group_by(nft_address)%>%
  summarize(last_time = max(timestamp))
last_trans_df$last_time_hr <- as.POSIXct(as.numeric(last_trans_df$last_time), origin = "1970-01-01")
last_trans_df

# Difference in Transfer Time
time_dif_df <- merge(first_mint_df,last_trans_df,by = 'nft_address')
time_dif_df$diff <- time_dif_df$last_time - time_dif_df$first_time
time_dif_df$diff_hr <- time_dif_df$last_time_hr - time_dif_df$first_time_hr
time_dif_df

# Combining dataset
combo_df <- merge(time_dif_df,mean_transfer_value_df,by = 'nft_address')
combo_df <- merge(combo_df,count_transfers_df,by = 'nft_address')
combo_df <- merge(combo_df,count_unique_transfers_df,by = 'nft_address')
combo_df <- merge(combo_df,unique_owner_df,by = 'nft_address')
combo_df <- merge(combo_df,count_nfts_df,by = 'nft_address')
combo_df <- merge(combo_df,mint_min_value_df,by = 'nft_address')
combo_df <- merge(combo_df,mint_max_value_df,by = 'nft_address')
combo_df <- merge(combo_df,mint_mean_value_df,by = 'nft_address')
combo_df <- merge(combo_df,avg_value_df,by = 'nft_address')

# Scaling values 
combo_df_reduced = combo_df
combo_df_reduced$mean_trans_val = combo_df_reduced$mean_trans_val/1000000000000
combo_df_reduced$mint_min_val = combo_df_reduced$mint_min_val/1000000000000
combo_df_reduced$mint_max_val = combo_df_reduced$mint_max_val/1000000000000
combo_df_reduced$mint_mean_val = combo_df_reduced$mint_mean_val/1000000000000
combo_df_reduced$current_mean_val = combo_df_reduced$current_mean_val/1000000000000
head(combo_df_reduced)
write.csv(combo_df_reduced,"valid_combo_df.csv", row.names = F)
