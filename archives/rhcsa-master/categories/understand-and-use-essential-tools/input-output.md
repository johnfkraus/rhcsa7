Redirect stdout with 1>
```
app 1>/dev/null
```

Redirect stderr with 2>
```
app 2>/dev/null
```

Refer to the other
```
app 1>/dev/null 2>&1
app 2>/dev/null 1>&2
```
