<script>
    import { onMount } from 'svelte';
    import Modeswitch from './Modeswitch.svelte';
    onMount(() => {
        console.log('mounted nav');
    });

</script>

  <div class="navbar bg-base-100 w-full shadow-xl fixed top-0 z-50">
    <div class="navbar-start">
      <ul class="menu menu-horizontal px-1">
        <li><a href="#work">Work</a></li>
        <li><a href='#web3'>Web3</a></li>
      </ul>
    </div>
    <div class="navbar-center">
      <ul class="menu menu-horizontal px-1">
        <li class=""><img src="twitter.svg" alt="landing"></li>
      </ul>
    </div>
    <div class="navbar-end">
      <Modeswitch />
    </div>
  </div>

<style>
  @keyframes float {
        0% {
            transform: translateY(-3px);
        }
        50% {
            transform: translateY(-15px);
        }
        100% {
            transform: translateY(-3px);
        }
    }

</style>