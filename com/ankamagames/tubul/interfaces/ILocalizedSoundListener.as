package com.ankamagames.tubul.interfaces
{
    import flash.utils.Dictionary;

    public interface ILocalizedSoundListener 
    {

        function get entitySounds():Array;
        function get reverseEntitySounds():Dictionary;
        function addSoundEntity(_arg_1:ISound, _arg_2:int):void;
        function removeSoundEntity(_arg_1:ISound):void;

    }
}//package com.ankamagames.tubul.interfaces

