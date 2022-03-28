import React, { useState, useRef } from 'react';

export default function ContractCall({ user, fetchBalance, contract, message, fetchContractMessage }) {
  const [newMessage, setNewMessage] = useState('');
  const [disabled, setDisabled] = useState(false);
  const [txnHash, setTxnHash] = useState();
  const updateBtnRef = useRef();

  // Update contract `message` value on the blockchain
  const mint = async () => {
    let { transactionHash } = await contract.methods.safeMint(user.publicAddress).send({ from: user.publicAddress });
    setTxnHash(transactionHash)
  }


  return (
    <div className='container'>
          <h1>Mint NFT</h1>
          <button disabled={disabled} ref={updateBtnRef} onClick={mint}>Mint</button>
          {txnHash &&
            <div className='info'>
              <a href={`https://alfajores-blockscout.celo-testnet.org/tx/${txnHash}`} target='_blank'>
                View Transaction
              </a> ↗️
            </div>}
        </div>
  )
}