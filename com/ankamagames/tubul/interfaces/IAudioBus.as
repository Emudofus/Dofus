package com.ankamagames.tubul.interfaces
{
    import __AS3__.vec.Vector;
    import com.ankamagames.tubul.types.VolumeFadeEffect;

    public interface IAudioBus extends ISoundController 
    {

        function get soundList():Vector.<ISound>;
        function get id():uint;
        function get name():String;
        function set volumeMax(_arg_1:Number):void;
        function get volumeMax():Number;
        function get numberSoundsLimitation():int;
        function set numberSoundsLimitation(_arg_1:int):void;
        function addISound(_arg_1:ISound):void;
        function playISound(_arg_1:ISound, _arg_2:Boolean=false, _arg_3:int=-1):void;
        function clear(_arg_1:VolumeFadeEffect=null):void;
        function contains(_arg_1:ISound):Boolean;
        function clearCache():void;

    }
}//package com.ankamagames.tubul.interfaces

