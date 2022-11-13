## 概要
- Excelの入力したいセルに[セルの名前](https://support.microsoft.com/ja-jp/office/%E6%95%B0%E5%BC%8F%E3%81%A7%E5%90%8D%E5%89%8D%E3%82%92%E5%AE%9A%E7%BE%A9%E3%81%97%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B-4d0f13ac-53b7-422e-afd2-abd7ff379c64)を設定し、Excelをテンプレートとして登録します。
- 外部サイトからJavaScriptなどを利用して後述の形式でリクエストする事で、指定のセルに値を入力したExcelが作成されます。
- 作成されたExcelはbase64エンコーディングされて返却される為、デコードしExcelファイルとしてダウンロードすることができます。
- 明細ではない単一のセルの場合、下記のようにリクエストします。
    ```
    cell: {
        セルの名前: {
            value: 入力する内容
        }
    }
    ```
- 明細のセルの場合、下記のようにリクエストします。
    ```
    row: {
        明細行の名前: {
            value: [
                {
                    （1行目）セルの名前: {
                        value: 入力する内容
                    }
                },
                {
                    （2行目）セルの名前: {
                        value: 入力する内容
                    }
                },
                .
                .
                .
            ]
        }
    }
    ```

## Request
### URL
https://xlsx-creator.com/api/v1/form

### method
POST

### header
```json
{
   "Content-Type": "application/json",
   "X-XLSX-CREATOR-EMAIL": "YOUR-EMAIL",
   "X-XLSX-CREATOR-PASSWORD": "YOUR-PASSWORD",
}
```

### body
```json
{
  "formId": "1",
    "data": {
    "cell": {
      "field1": {
        "value": "hello"
      },
      "field2": {
        "value": "world"
      }
    },
    "row": {
      "detail": {
        "value": [
          {
            "filedInRow1-1": {
              "value": "value_1-1"
            },
            "filedInRow1-2": {
              "value": "value_1-2"
            },
            "filedInRow1-3": {
              "value": "value_1-3"
            }
          },
          {
            "filedInRow2-1": {
              "value": "value_2-1"
            },
            "filedInRow2-2": {
              "value": "value_2-2"
            },
            "filedInRow2-3": {
              "value": "value_2-3"
            }
          }
        ]
      }
    }
  }
}
```

## Response
### success
```json
{
   base64: "base64 encoded data"
}
```

### error
```json
{
   message: "error message"
}
```

## Sample

```javascript
// 受け取ったbase64データをデコードし、ダウンロードする
const download = (base64) => {
    // 任意のファイル名でダウンロード
    const filename = 'created.xlsx';
    const binary = atob(base64);
    const decoded_array = new Uint8Array(Array.prototype.map.call(binary, c => c.charCodeAt()));
    const decoded = new Blob([decoded_array], {type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"});
    const url = window.URL.createObjectURL(decoded);
    const a = document.createElement("a");
    a.href = url;
    a.download = filename;
    a.click();
    window.URL.revokeObjectURL(url);
}
await fetch("https://xlsx-creator.com/api/v1/form", {
    method: "POST",
    headers: {
        "Content-Type": "application/json",
        "X-XLSX-CREATOR-EMAIL": "your email",
        "X-XLSX-CREATOR-PASSWORD": "your password"
    },
    body: JSON.stringify({
        // form id you want to create
        "formId": "1",
        // json format data you want to input
        "data": {
            "cell": {
                "field1": {
                    "value": "hello"
                },
                "field2": {
                    "value": "world"
                }
            },
            "row": {
                "detail": {
                    "value": [
                        {
                            "filedInRow1-1": {
                                "value": "value_1-1"
                            },
                            "filedInRow1-2": {
                                "value": "value_1-2"
                            },
                            "filedInRow1-3": {
                                "value": "value_1-3"
                            }
                        },
                        {
                            "filedInRow2-1": {
                                "value": "value_2-1"
                            },
                            "filedInRow2-2": {
                                "value": "value_2-2"
                            },
                            "filedInRow2-3": {
                                "value": "value_2-3"
                            }
                        }
                    ]
                }
            }
        }
    })
}).then(async (resp) => {
    if (resp.status === 200) {
        const {base64} = await resp.json();
        download(base64);
    }
})
```

# 制限事項
- 1ユーザーにつき、テンプレートは2つまで登録可能です。
- 1つのテンプレートのサイズ上限は約1MBです。
- Excel作成処理は5秒以上経過すると、タイムアウトとなります。