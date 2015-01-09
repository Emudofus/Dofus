package com.ankamagames.dofus.kernel.updaterv2
{
    import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;

    public interface IUpdaterMessageHandler 
    {

        function handleConnectionOpened():void;
        function handleMessage(_arg_1:IUpdaterInputMessage):void;
        function handleConnectionClosed():void;

    }
}//package com.ankamagames.dofus.kernel.updaterv2

