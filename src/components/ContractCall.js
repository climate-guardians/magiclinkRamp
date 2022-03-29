import React, { useState, useRef } from 'react';

export default function ContractCall({ user, fetchBalance, contract, message, fetchContractMessage }) {
  const [txnHash, setTxnHash] = useState();
  const [txnHashPack, setTxnHashPack] = useState();
  const updateBtnRef = useRef();

  // Update contract `message` value on the blockchain
  const mint = async () => {
    let { transactionHash } = await contract.methods.mint(user.publicAddress, 2, 1, 0x0000).send({ from: user.publicAddress , value: "0x2386f26fc10000"});
    setTxnHash(transactionHash)
  }

  const openPack = async () => {
    let { transactionHash } = await contract.methods.openPack(user.publicAddress, 2, 1, '0x4aEc1eF9b891C6EbB63634a97760e4107dcA28E6', '0xe7857a1691600C8b3D7e6dAC95dc4DAF65e1c8fc', '0x10BbEd3B0f93690A503366A0325FCad8Ac487cbE').send({ from: user.publicAddress});
    setTxnHashPack(transactionHash)
  }


  return (
    <div className='container'>
        <h1>Contract interaction</h1>
          <button ref={updateBtnRef} onClick={mint}>Mint Pack</button>
          {txnHash &&
            <div className='info'>
              <a href={`https://alfajores-blockscout.celo-testnet.org/tx/${txnHash}`} target='_blank'>
                View Transaction
              </a> ↗️
            </div>}
          <button ref={updateBtnRef} onClick={openPack}>Open Pack</button>
          {txnHashPack &&
            <div className='info'>
              <a href={`https://alfajores-blockscout.celo-testnet.org/tx/${txnHash}`} target='_blank'>
                View Transaction
              </a> ↗️
            </div>}
    </div>



  )
}