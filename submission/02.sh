# Create a raw transaction that can be spent in 2 weeks time, assuming the current block is 25

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

#Decode to get TXID
decode_tx=$(bitcoin-cli -regtest decoderawtransaction "$transaction")

TXID=$(echo "$decode_tx" | jq -r '.txid')
recipient="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
amount=0.200000000

#Get current block and calculate lock time
current_block=25

absolute_timeblock=$((current_block + 2016))

#Define input and output

timelock_input='[{"txid":"'$TXID'","vout":0}, {"txid":"'$TXID'","vout":1}]'
timelock_output='[{"'$recipient'":'$amount'}]'


# Create the time-locked raw transaction
timelock_tx=$(bitcoin-cli -regtest createrawtransaction "$timelock_input" "$timelock_output" $absolute_timeblock)
echo "$timelock_tx"