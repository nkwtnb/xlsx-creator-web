const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
    plugins: [
        new MiniCssExtractPlugin({
            filename: "../stylesheets/[name].css"
        })
    ],
    entry: {
        "home/index": './frontend/src/foo.js',
        "sessions/index": './frontend/src/bar.ts'
    },
    output: {
        path: path.resolve(__dirname, "app", "assets","javascripts"),
        filename: "[name].js"
    },
    module: {
        rules: [
            {
                test: /\.ts$/,
                use: 'ts-loader'
            },
            {
                test: /\.css$/i,
                use: [MiniCssExtractPlugin.loader, "css-loader"],
            },
        ]
    },
    resolve: {
        extensions: [
            '.ts', '.js'
        ]
    }
};