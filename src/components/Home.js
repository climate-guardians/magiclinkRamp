import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { magic, web3 } from '../magic';
import { abi } from '../contract/abi.js';
import Loading from './Loading';
import ContractCall from './ContractCall';
import SendTransaction from './SendTransaction';
import Info from './Info';
import { RampInstantSDK } from '@ramp-network/ramp-instant-sdk';

export default function Home() {
  const [userMetadata, setUserMetadata] = useState();
  const [balance, setBalance] = useState('...');
  const contractAddress = '0xe908B2756699876267B02A5cFCf1C7363834909a';
  const contract = new web3.eth.Contract(abi, contractAddress);
  const history = useHistory();

  const buyFunds = (address) => { 
    /*
   *  Advanced Integration
   */
  const ramp = new RampInstantSDK({
    hostAppName: 'Ramp Demo',
    hostLogoUrl: 'https://rampnetwork.github.io/assets/misc/test-logo.png',
    swapAmount: '10000000000000',
    swapAsset: 'ETH',
    userAddress: address,
    url: 'https://ri-widget-staging.firebaseapp.com/', // only specify the url if you want to use testnet widget versions,
    // use variant: 'auto' for automatic mobile / desktop handling,
    // 'hosted-auto' for automatic mobile / desktop handling in new window,
    // 'mobile' to force mobile version
    // 'desktop' to force desktop version (default)
    variant: 'auto', 
  }).on('*', (event) => {
    console.log(`RampSdk.on('*')`, event);
  });

  ramp?.show();
  }
  

  useEffect(() => {
    // On mount, we check if a user is logged in.
    // If so, we'll retrieve the authenticated user's profile, balance and contract message.
    magic.user.isLoggedIn().then(magicIsLoggedIn => {
      if (magicIsLoggedIn) {
        magic.user.getMetadata().then(user => {
          setUserMetadata(user);
          fetchBalance(user.publicAddress);
          mintNFT(user.publicAddress);
        });
      } else {
        // If no user is logged in, redirect to `/login`
        history.push('/login');
      }
    });
  }, [magic]);

  const fetchBalance = (address) => {
    web3.eth.getBalance(address).then(bal => setBalance(web3.utils.fromWei(bal)))
  }

  const mintNFT = (useraddress) => contract.methods.safeMint(useraddress).call();

  return (
    userMetadata ? (
      <>
        <Info balance={balance} user={userMetadata} magic={magic} />
        <button onClick={buyFunds}>Run Ramp Widget </button>
        <SendTransaction web3={web3} user={userMetadata} fetchBalance={fetchBalance} />
        <ContractCall contract={contract} user={userMetadata} fetchBalance={fetchBalance} message={0} fetchContractMessage={0} />  
      </>
    ) : <Loading />
  );
}

