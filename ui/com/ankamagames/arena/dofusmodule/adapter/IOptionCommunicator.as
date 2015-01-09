package com.ankamagames.arena.dofusmodule.adapter
{
    import flash.events.IEventDispatcher;

    public interface IOptionCommunicator extends IEventDispatcher 
    {

        function destroy():void;
        function getHostCurrentLanguage():String;
        function isSoundActivated():Boolean;
        function setMusicVolume(_arg_1:Number):void;
        function setAmbianceVolume(_arg_1:Number):void;
        function setSoundVolume(_arg_1:Number):void;
        function getMusicVolume():Number;
        function getAmbianceVolume():Number;
        function getSoundVolume():Number;

    }
}//package com.ankamagames.arena.dofusmodule.adapter

