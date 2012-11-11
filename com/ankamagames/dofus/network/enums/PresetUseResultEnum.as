package com.ankamagames.dofus.network.enums
{

    public class PresetUseResultEnum extends Object
    {
        public static const PRESET_USE_OK:uint = 1;
        public static const PRESET_USE_OK_PARTIAL:uint = 2;
        public static const PRESET_USE_ERR_UNKNOWN:uint = 3;
        public static const PRESET_USE_ERR_CRITERION:uint = 4;
        public static const PRESET_USE_ERR_BAD_PRESET_ID:uint = 5;

        public function PresetUseResultEnum()
        {
            return;
        }// end function

    }
}
