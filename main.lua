Confirm = {} 
local ConfirmBusy = false 

RegisterNetEvent('CreateConfirm')
AddEventHandler('CreateConfirm', function(Title,Button1,Button2,cb) 
    Confirm.Create(Title,Button1,Button2,cb)
end)

Confirm.Create = function(Title,Button1,Button2,cb)
    if not ConfirmBusy then 
        ConfirmBusy = true 
    else 
        error('Error to creating mutiple Confirms')
        return 
    end 
        TriggerEvent('CallScaleformMovie',"nbk_confirm",function(run,send,stop,handle)
            run('DISPLAY_CONFIRM')
            send(Title,Button1,Button2)
            stop()
            local Hide = true 
            run("SET_ANALOG_STICK_INPUT");
            send(0.0,0.0,(ToFloat(-200) * (1.0 + (10.0 * Timestep()))));
            Hide = false
            stop()
            
            Threads.CreateLoopOnce('CreateConfirm',0,function()
                if handle then 
                    if IsControlJustPressed(2, 177)  then
                        if Hide then 
                            run("SET_ANALOG_STICK_INPUT");
                            send(0.0,0.0,(ToFloat(-200) * (1.0 + (10.0 * Timestep()))));
                            Hide = false
                            stop()
                        else 
                            TriggerEvent('EndScaleformMovie','nbk_confirm')
                            handle = nil 
                            Threads.KillLoop('CreateConfirm',0);
                            cb (-1)
                            ConfirmBusy = false 
                        end 
                    end 
                    if not Hide then 
                        --SetMouseCursorActiveThisFrame()
                    
                    if (IsControlJustPressed(2, 201) or IsControlJustPressed(2, 223) ) then  
                        run(bankForm, "SET_INPUT_SELECT")
                        stop()
                        
                        TriggerEvent('RequestScaleformCallbackInt',"nbk_confirm",'GET_CURRENT_SELECTION',function(data)
                            TriggerEvent('EndScaleformMovie','nbk_confirm')
                            handle = nil 
                            Threads.KillLoop('ComfrimInput',0);
                            cb(data)
                            ConfirmBusy = false 
                        end)
                    end
                    if IsControlJustPressed(2, 188)  then
                        run("SET_INPUT_EVENT");
                        send(8);
                        stop();
                    end 
                    if IsControlJustPressed(2, 187)then
                        
                        run("SET_INPUT_EVENT");
                        send(9);
                        stop();
                    end
                    if IsControlJustPressed(2, 189)then
                        run("SET_INPUT_EVENT");
                        send(10);
                        stop();
                    end 
                    if IsControlJustPressed(2, 190)then
                        run("SET_INPUT_EVENT");
                        send(11);
                        stop();
                    end
                    end
                    if  IsControlPressed(0, 187) or IsControlPressed(0, 188) then
                        
                        fVar2 = (1.0 + (10.0 * Timestep()));
                        if (IsControlPressed(0, 187))
                        then
                            iVar1 = 200;
                        end 
                        if (IsControlPressed(0, 188))
                        then
                            iVar1 = -200;
                        end 
                        
                        if ToFloat(iVar1) * fVar2 <0 then 
                            
                            Hide = false 
                        else 
                            Hide = true
                        end 
                        
                        run("SET_ANALOG_STICK_INPUT");
                        send(0.0,0.0,(ToFloat(iVar1) * fVar2));
                        stop()
                    
                    
                    end
                end 
            end )
            TriggerEvent('DrawScaleformMovie','nbk_confirm')
            
        end)
        
        
   

end 
CreateThread(function()
    Confirm.Create('是否清除此則建言?',"清除","取消",function(selection)
        if selection == 1 then
            print('yes')
        elseif selection == 2 then
            print('no')
        else 
            print('cancel')
        end 
    end )


    

end)