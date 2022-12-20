<script>
	import { ethers } from 'ethers';
	import { onMount } from 'svelte';

	import MessageABI from '../ABI/ABIforBoard.json';

	let userAddress = null;
	let network = null;
	let balance = null;
	let isConnected = false;
	let provider = null;

	let contractAddress = '0xbd784e82546e679D3d0AFB06a543a6D9788a8259';
	
	let amItheOwner = false;

	let contract = null;
	let allMessages = [];
	let sendingMessage = false;

    let noWallet;

	/* Setup the contract */

	async function setupContract() {
		if (isConnected && provider) {
			contract = new ethers.Contract(contractAddress, MessageABI, provider);
			const contractOwner = await contract.owner();
			amItheOwner = ethers.utils.getAddress(contractOwner) === ethers.utils.getAddress(userAddress);
			contract.on('NewMessage', async () => {
				balance = await provider.getBalance(userAddress);
				await getMessages();
				sendingMessage = false;
			});
		}
	}

	async function sendMessage(event) {
		const formData = new FormData(event.target);
		if (formData.get('name') === '') {
			alert('Please enter an amount');
			return;
		}
        if (formData.get('message') === '') {
			alert('Please enter a message');
			return;
		}
		sendingMessage = true;
		const data = {};
		for (let field of formData) {
			const [key, value] = field;
			data[key] = value;
		}
		// perform the transaction
		// get the signer of the transaction and a read-write instance of the contract
		const rwContract = new ethers.Contract(contractAddress, MessageABI, provider.getSigner());
		const transaction = await rwContract.sendMessage(data.message, data.name);
		await transaction.wait();
	}


	async function getMessages() {
		if (isConnected) {
			const messages = await contract.getAllMessages();
			allMessages = [
				...messages.map((item) => {
					return {
						address: item.sender,
						timestamp: new Date(item.timestamp * 1000).toLocaleDateString(),
						message: item.message,
						name: item.name,
					};
				})
			];
		}
	}

	/* Basic account setup */
	async function setup(accounts) {
		userAddress = accounts[0]; // update the state
		// Get and update the ethereum provider
		try {
			provider = new ethers.providers.Web3Provider(window.ethereum);
			network = await provider.getNetwork();
			balance = await provider.getBalance(userAddress);
			isConnected = true;
			await setupContract();
			await getMessages();
			window.ethereum.on('accountsChanged', (accounts) => {
				window.location.reload();
			});
		} catch (e) {
			console.error(e);
		}
	}

	async function connectWallet() {
		if (window.ethereum) {
			// ethereum is an object injected by the wallet. Let's check if is available
			const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' }); // use the request method to get the accounts, aka logging in to Metamask
			if (accounts.length > 0) {
				await setup(accounts);
			} else {
				alert('No ethereum accounts found');
			}
		} else {
			noWallet = true;
		}
	}

	// Let's avoid clicking connect every time and check if the wallet was already connected
	onMount(async () => {
		if (window.ethereum) {
			const accounts = await window.ethereum.request({ method: 'eth_accounts' }); // get the accounts

			if (accounts.length > 0) {
				await setup(accounts);
			}
		}
	});

</script>
<div id="web3" class="bg-base-100 rounded-3xl pb-16">
    <h2 class="text-4xl xl:text-7xl font-medium text-center mb-8">Web3</h2>
	{#if isConnected}


        <div class="w-screen h-auto flex flex-col">
            <div class="card bg-base-200 w-full xl:w-1/2 bg-base-300 mx-auto">
                <div class="card-body bg-base-200 rounded-2xl">
                  <h2 class="card-title">Connected as: {userAddress}</h2>
                  <p class="mb-8">Network: {network.name} (only works on goerli for now)</p>
                  {#each allMessages as item}
                  <div class="chat chat-start mb-2">
                      <div class="chat-header">
                      {item.address}( {item.name})<br>
                      <time class="text-xs opacity-50">{item.timestamp}</time>
                      </div>
                      <div class="chat-bubble bg-base-300 text-white">{item.message}</div>
                      <div class="chat-footer opacity-50">
                      Seen
                      </div>
                  </div>
                  {/each}
                  
                    <form on:submit|preventDefault={sendMessage}>
                            <input type="text" class="input w-1/4 mb-2" placeholder="Nickname" name="name"/>
                            <input type="text" class="input w-3/4 mr-0" placeholder="Message" name="message"/>
                            <button type="submit" class="btn text-white ">Send Message</button>
                        
                    </form>
                    
                  
                </div>
            </div>
        </div>
	
{:else}
{#if !noWallet}
<div class="grid h-full place-items-center">
	<button
		class="btn btn-primary"
		on:click={connectWallet}>Connect with Wallet</button
	>
</div>
{/if}
{/if}

</div>