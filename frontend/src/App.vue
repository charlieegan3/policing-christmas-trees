<template>
  <div id="app">
    <div>
      <router-link to="/">Home</router-link>
      <router-link to="/about">About</router-link>
    </div>
    <router-view :key="$route.fullPath"></router-view>
  </div>
</template>

<style>
#app {
  font-family: "IBM Plex Serif", serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.sans-serif {
  font-family: "Montserrat", sans-serif;
}
</style>
