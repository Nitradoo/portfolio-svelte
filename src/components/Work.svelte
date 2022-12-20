<script>
    import { onMount } from 'svelte';

    let data = [];
        onMount(async () => {
            const response = await fetch('https://api.github.com/users/nitradoo/repos');
            data = await response.json();
            console.log(data);
        });

</script>
<div id="work" class="h-auto w-screen min-h-screen mx-auto">
    <div class="flex flex-col gap-8 gap-x-8 w-4/6 h-full p-8 mx-auto">
        <h2 class="text-4xl xl:text-7xl font-medium text-center anotheremoji">Work</h2>
        {#if data}
        {#each data as repo}
        <div class="card w-full xl:w-1/2 bg-base-300 text-base-content mx-auto hover:scale-105 transition duration-300 delay-150 ease-in-out">
            <a href={repo.html_url}>
            <div class="card-body">
              <h2 class="card-title">{repo.name}</h2>
              <p class="text-lg">{repo.description}</p>
              <div class="card-actions justify-left">
                <p class="text-md">{repo.language}</p>
              </div>
            </div>
        </a>
          </div>
        {/each}
        {/if}
    </div>
</div>

<style>
    @keyframes float {
        0% {
            transform: translateY(7px);
        }
        50% {
            transform: translateY(-15px);
        }
        100% {
            transform: translateY(7px);
        }
    }
.anotheremoji::after{
    height: 200px;
    font-size: 300px;
    content: "⟁";
    font-weight: 300;
    z-index: 2;
    user-select: none;
    transform: translateY(-5%) translate(97%);
    -webkit-text-stroke: 2px white;
    color: transparent;
    opacity: .6;
    position: absolute;
    left:80vw;
    top:120vh;
    rotate: 70deg;
    animation: float 7s ease-in-out infinite;
  }
</style>