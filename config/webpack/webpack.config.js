const { webpackConfig, merge } = require('shakapacker')

let miniCssExtractPlugin = webpackConfig.plugins.find((p, i) => { return p.constructor.name === 'MiniCssExtractPlugin' });

if (miniCssExtractPlugin && miniCssExtractPlugin.options) {
  miniCssExtractPlugin.options.filename = 'css/[name]-[contenthash:8].css';
  miniCssExtractPlugin.options.chunkFilename = 'css/[id]-[contenthash:8].css';
}

const customConfig = {
  output: {
    filename: 'js/[name]-[contenthash].js',
    chunkFilename: 'js/[name]-[contenthash].chunk.js'
  }
}

module.exports = merge(webpackConfig, customConfig)
