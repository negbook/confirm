# fxserver-Confirm
Confirm script for FXServer  


[DEPENDENCIES]  
[Threads](https://forum.cfx.re/t/lib-threads-good-for-loops/2089076)  
[Scaleforms](https://forum.cfx.re/t/release-utility-scaleforms-utilities-for-fxserver/2166362)  

[INSTALLATION-1]   

```
start confirm
```

[EXAMPLE-1]
```
TriggerEvent('CreateConfirm',title,button1,button2,function(selection)
    if selection == 1 then
        print('yes')
    elseif selection == 2 then
        print('no')
    else 
        print('cancel')
    end 
end )
```

[INSTALLATION-2]  

your script's fxmanifest.lua :
```
client_scripts {
'@threads/threads.lua',
'@scaleforms/scaleforms.lua',
'@confirm/confirm.lua'
}
```
[EXAMPLE-2]
```
Confirm.Create(title,button1,button2,function(selection)
    if selection == 1 then
        print('yes')
    elseif selection == 2 then
        print('no')
    else 
        print('cancel')
    end 
end )
```