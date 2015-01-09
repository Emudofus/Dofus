package com.ankamagames.tubul.interfaces
{
    import __AS3__.vec.Vector;
    import com.ankamagames.tubul.types.VolumeFadeEffect;

    public interface ISoundController extends IEventDispatcher 
    {

        function get effects():Vector.<IEffect>;
        function get volume():Number;
        function set volume(_arg_1:Number):void;
        function get currentFadeVolume():Number;
        function set currentFadeVolume(_arg_1:Number):void;
        function get effectiveVolume():Number;
        function addEffect(_arg_1:IEffect):void;
        function removeEffect(_arg_1:IEffect):void;
        function applyDynamicMix(_arg_1:VolumeFadeEffect, _arg_2:uint, _arg_3:VolumeFadeEffect):void;

    }
}//package com.ankamagames.tubul.interfaces

