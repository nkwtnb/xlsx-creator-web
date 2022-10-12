const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
    plugins: [
        new MiniCssExtractPlugin({
            filename: "../stylesheets/[name].css"
        })
    ],
    entry: {
        "home/index": './frontend/src/entry.ts',
        "sessions/index": './frontend/src/foo.js',
    },
    output: {
        path: path.resolve(__dirname, "app", "assets","javascripts"),
        filename: "[name].js"
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: [
                    {
                        loader: "babel-loader",
                        options: {
                            presets: [
                                "@babel/preset-env",
                                "@babel/preset-react",
                                "@babel/preset-typescript",

                            ]
                        }
                    }
                ]
            },
            {
                test: /\.css$/i,
                use: [MiniCssExtractPlugin.loader, "css-loader"],
            },
        ]
    },
    resolve: {
        extensions: [
            '.ts',
            '.tsx',
            '.js',
            '.jsx',
        ]
    }
};