<script>
    import { onMount } from "svelte";

    let data = [];

    onMount(async () => {
        const response = await fetch(
            "https://api.github.com/users/nitradoo/repos"
        );
        data = await response.json();
        console.log(data);
    });
</script>

<div id="work" class="min-w-full min-h-full mx-auto">
    <div class="flex flex-col gap-8 gap-x-8 w-screen h-full p-8 mx-auto">
        <h2 class="text-4xl xl:text-7xl font-medium text-center anotheremoji">
            Work
        </h2>
        {#if data}
            {#each data as repo}
                <div
                    class="card w-[80%] lg:w-1/3 bg-base-300 text-base-content mx-auto hover:scale-105 transition duration-300 delay-150 ease-in-out opacity-[.90]"
                >
                    <a href={repo.html_url}>
                        <div class="card-body">
                            <div class="card-actions justify-between">
                                <h2 class="card-title text-3xl font-bold">
                                    {repo.name}
                                </h2>
                                <img src="github-mark.svg" alt="github-icon" />
                            </div>
                            <p class="text-lg font-light">{repo.description}</p>
                            <div class="card-actions justify-left">
                                <kbd class="kbd">{repo.language}</kbd>
                                <div class="flex gap-0 items-center">
                                    <img
                                        src="github-star-2.svg"
                                        class="w-6"
                                        alt="github-star"
                                    />
                                    <p>{repo.stargazers_count}</p>
                                </div>
                                <div class="flex gap-0 items-center">
                                    <img
                                        src="github-fork.svg"
                                        class="w-6"
                                        alt="github-fork"
                                    />
                                    <p>{repo.forks_count}</p>
                                </div>
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
    .anotheremoji::after {
        height: 200px;
        font-size: 300px;
        content: "⟁";
        font-weight: 300;
        z-index: 0;
        user-select: none;
        transform: translateY(-5%) translate(97%);
        -webkit-text-stroke: 2px white;
        color: transparent;
        opacity: 0.6;
        position: absolute;
        left: 70%;
        top: 135%;
        rotate: 70deg;
        animation: float 7s ease-in-out infinite;
    }

    @media(max-width:1280px){
        .anotheremoji::after{
            display:none;
        }
    }
</style>
