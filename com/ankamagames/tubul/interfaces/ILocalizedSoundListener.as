package com.ankamagames.tubul.interfaces
{
    import flash.utils.*;

    public interface ILocalizedSoundListener
    {

        public function ILocalizedSoundListener();

        function get entitySounds() : Array;

        function get reverseEntitySounds() : Dictionary;

        function addSoundEntity(param1:ISound, param2:int) : void;

        function removeSoundEntity(param1:ISound) : void;

    }
}
