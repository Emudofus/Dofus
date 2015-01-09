package com.ankamagames.dofus.kernel.updaterv2.messages
{
    import com.ankamagames.jerakine.messages.QueueableMessage;

    public interface IUpdaterInputMessage extends QueueableMessage 
    {

        function deserialize(_arg_1:Object):void;

    }
}//package com.ankamagames.dofus.kernel.updaterv2.messages

