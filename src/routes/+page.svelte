<script>
    import Modeswitch from '../components/Modeswitch.svelte';
    import Hero from '../components/Hero.svelte';
    import Nav from '../components/Nav.svelte';
    import Work from '../components/Work.svelte';
</script>
<Nav />
<Hero />
<Work />



<style>
    :global(body){
        transition: background-color 0.4s ease-in-out;
        overflow-x: hidden;
    }
    :global(html){
        scroll-behavior: smooth;
    }
</style>