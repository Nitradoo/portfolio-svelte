<script>
    import Modeswitch from '../components/Modeswitch.svelte';
    import Hero from '../components/Hero.svelte';
    import Nav from '../components/Nav.svelte';
    import Work from '../components/Work.svelte';
    import Web3 from '../components/Web3.svelte'
</script>

<Nav />
<Hero />
<Work />
<Web3 />

<style>
:global(body){
    transition: background-color 0.4s ease-in-out;
}
:global(html){
    scroll-behavior: smooth;
}
</style>