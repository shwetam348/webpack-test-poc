const path = require('path');

module.exports = {
  entry: './src/index.js', // Entry point
  output: {
    filename: '[name].[contenthash].js', // this will generate unique file names
    path: path.resolve(__dirname, 'dist'), // Output directory,
    clean: false, // Ensure clean is false so older files aren't deleted

  },
  module: {
    rules: [
      {
        test: /\.js$/, // Apply Babel to JS files
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  mode: 'production', // Development mode
};
