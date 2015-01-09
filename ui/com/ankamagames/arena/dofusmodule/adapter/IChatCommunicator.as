package com.ankamagames.arena.dofusmodule.adapter
{
    import flash.events.IEventDispatcher;

    public interface IChatCommunicator extends IEventDispatcher 
    {

        function destroy():void;
        function addUserMessage(_arg_1:String, _arg_2:String):void;
        function addInfoMessage(_arg_1:String):void;

    }
}//package com.ankamagames.arena.dofusmodule.adapter

