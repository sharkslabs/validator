DESIRED_DOUBLEZERO_ENV=mainnet-beta
curl -1sLf https://dl.cloudsmith.io/public/malbeclabs/doublezero/setup.deb.sh | sudo -E bash
sudo apt-get install doublezero
doublezero keygen
doublezero address
/usr/local/bin/doublezero-solana passport request-solana-validator-access -u mainnet-beta   -k /home/firedancer/data/staked-identity.json   --node-id $(solana-keygen pubkey /home/firedancer/data/staked-identity.json)   --signature $(solana sign-offchain-message -k data/staked-identity.json service_key=$(doublezero address)) $(doublezero address)
sudo mkdir -p /etc/systemd/system/doublezerod.service.d
echo -e "[Service]\nExecStart=\nExecStart=/usr/bin/doublezerod -sock-file /run/doublezerod/doublezerod.sock -env $DESIRED_DOUBLEZERO_ENV" | sudo tee /etc/systemd/system/doublezerod.service.d/override.conf > /dev/null
sudo systemctl daemon-reload
sudo systemctl restart doublezerod
doublezero config set --env $DESIRED_DOUBLEZERO_ENV  > /dev/null
echo "✅ doublezerod configured for environment $DESIRED_DOUBLEZERO_ENV"
sleep 45
doublezero latency
doublezero connect ibrl