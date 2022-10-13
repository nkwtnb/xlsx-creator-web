## Request
### URL
[URL]/api/v1/form

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
const download = (base64) => {
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
await fetch("http://{URL}/api/v1/form", {
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
