<template>
  <div id="app" class="ph2">
    <h1 class="f3 f2-ns">Policing Christmas Trees</h1>
    <div>
      <router-link class="router-link" to="/">Tree Builder</router-link>
      <router-link class="router-link" to="/about">OMG wot iz this site...</router-link>
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
.router-link {
	padding: 2px 5px;
	text-decoration: none;
	border: 1px solid black;
	margin-right: 5px;
}
.router-link:hover {
	background-color: #eee;
}
.router-link-exact-active {
	border: 4px solid rgb(255, 99, 0);
}
</style>
