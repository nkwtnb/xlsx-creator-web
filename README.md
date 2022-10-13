# XLSX-Creator-Web
after passing to file path and json you want to input to the Excel,  
make Excel and return it base64 encoded.

## Request
### URL
[URL]/api/v1/form

### method
POST

### header
```
{
   "Content-Type": "application/json",
   "X-XLSX-CREATOR-EMAIL": "YOUR-EMAIL",
   "X-XLSX-CREATOR-PASSWORD": "YOUR-PASSWORD",
}
```

### body
```
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
```
{
   base64: "base64 encoded data"
}
```

### error
```
{
   message: "error message"
}
```
