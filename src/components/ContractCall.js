import React, { useState, useRef } from 'react';

export default function ContractCall({ web3, user, fetchBalance, contract, message, fetchContractMessage }) {
  const [txnHash, setTxnHash] = useState();
  const [txnHashPack, setTxnHashPack] = useState();
  const updateBtnRef = useRef();

  // Update contract `message` value on the blockchain
  const mint = async () => {
    let gasPrice = await web3.eth.getGasPrice();
    let { transactionHash } = await contract.methods.mint(1, "0x0000").send({ from: user.publicAddress , value: "0x5AF3107A4000", gasLimit: "0x1000000", gasPrice: gasPrice});
    setTxnHash(transactionHash)
  }

  const openPack = async () => {
    let gasPrice = await web3.eth.getGasPrice();
    let { transactionHash } = await contract.methods.openPack(0, 1).send({  from: user.publicAddress, gasLimit: "0x3D090", gasPrice: gasPrice});
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
              <a href={`https://alfajores-blockscout.celo-testnet.org/tx/${txnHashPack}`} target='_blank'>
                View Transaction
              </a> ↗️
            </div>}
    </div>



  )
}