<script>
    import { onMount } from 'svelte';
    
    function toggle(){
        if(window.document.body.getAttribute('data-theme') == 'luxury'){
            window.document.body.setAttribute('data-theme', 'night');
        } else {
            window.document.body.setAttribute('data-theme', 'luxury');
        }
    }
    onMount(() => {
        console.log('mounted modeswitch');
    });
</script>

<input type="checkbox" class="toggle bg-primary" checked on:click={toggle}/>

<style>
    input{
        transition: all 0.25s ease-in-out;
    }
</style>