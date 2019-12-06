module.exports = {
  devServer: {
    proxy: {
      '/api': {
        target: 'http://localhost:8181',
        secure: false,
        pathRewrite: {
          '/api': ''
        }
      }
    },
  },
}
