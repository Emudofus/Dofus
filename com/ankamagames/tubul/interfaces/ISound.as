package com.ankamagames.tubul.interfaces
{
    import com.ankamagames.tubul.types.SoundSilence;
    import com.ankamagames.jerakine.types.Uri;
    import flash.media.Sound;
    import com.ankamagames.tubul.types.VolumeFadeEffect;
    import com.ankamagames.jerakine.newCache.ICache;

    public interface ISound extends ISoundController 
    {

        function get silence():SoundSilence;
        function set silence(_arg_1:SoundSilence):void;
        function get duration():Number;
        function get stereo():Boolean;
        function get totalLoops():int;
        function get currentLoop():uint;
        function get uri():Uri;
        function get sound():Sound;
        function set sound(_arg_1:*):void;
        function get busId():int;
        function set busId(_arg_1:int):void;
        function get bus():IAudioBus;
        function get id():int;
        function get noCutSilence():Boolean;
        function set noCutSilence(_arg_1:Boolean):void;
        function get isPlaying():Boolean;
        function play(_arg_1:Boolean=false, _arg_2:int=0, _arg_3:VolumeFadeEffect=null, _arg_4:VolumeFadeEffect=null):void;
        function stop(_arg_1:VolumeFadeEffect=null):void;
        function loadSound(_arg_1:ICache):void;
        function setLoops(_arg_1:int):void;
        function setCurrentLoop(_arg_1:uint):void;
        function clone():ISound;

    }
}//package com.ankamagames.tubul.interfaces

