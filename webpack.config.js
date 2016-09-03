var path = require('path'),
  fs = require('fs')

module.exports = {
  entry: {
    app: ['./app/assets/js/main.js']
  },
  output: {
    path: path.resolve(__dirname, 'app'),
    publicPath: '/assets/',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.js?$/,
        loader: 'babel-loader',
        exclude: /(node_modules|bower_components)/,
        include: [
          path.resolve(__dirname, "app/assets/components"),
          path.resolve(__dirname, "app/assets/js"),
          path.resolve(__dirname, "app/assets/js/lib")
        ]
      },
      {
        test: /\.tag?$/,
        loader: 'tag-loader',
        exclude: /(node_modules|bower_components)/,
        query: {
          type: 'babel'
        }
      }
    ]
  }
}
