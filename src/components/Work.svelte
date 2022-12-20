<script>
    import { onMount } from 'svelte';

    let data = [];
        onMount(async () => {
            const response = await fetch('https://api.github.com/users/nitradoo/repos');
            data = await response.json();
            console.log(data);
        });

</script>
<div class="h-auto w-screen mx-auto">
    <div id="work" class="flex flex-col gap-8 gap-x-8 w-4/6 h-full p-8 mx-auto">
        {#if data}
        {#each data as repo} 
        <div class="card w-full xl:w-1/2 bg-base-300 text-base-content mx-auto">
            <div class="card-body">
              <h2 class="card-title">{repo.name}</h2>
              <p class="text-lg">{repo.description}</p>
              <div class="card-actions justify-left">
                <p class="text-md">{repo.language}</p>
              </div>
            </div>
          </div>
        {/each}
        {/if}
    </div>
</div>