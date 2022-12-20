/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/routes/**/*.{svelte,js,ts}",
    "./src/components/**/*.{svelte,js,ts}",
  ],
  theme: {
    fontFamily: {
      sans: ["Montserrat", 'sans-serif'],
    },
    extend: {},
  },
  plugins: [require('daisyui')],
}
