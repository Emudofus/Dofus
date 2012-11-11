package com.ankamagames.tubul.factory
{
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.bus.*;

    public class AudioBusFactory extends Object
    {

        public function AudioBusFactory()
        {
            return;
        }// end function

        public static function getAudioBus(param1:uint, param2:uint, param3:String) : IAudioBus
        {
            switch(param1)
            {
                case EnumTypeBus.LOCALIZED_BUS:
                {
                    return new LocalizedBus(param2, param3);
                }
                case EnumTypeBus.UNLOCALIZED_BUS:
                {
                    return new UnlocalizedBus(param2, param3);
                }
                default:
                {
                    break;
                }
            }
            throw new ArgumentError("Unknown audio bus type " + param1 + ". See EnumTypeBus !");
        }// end function

    }
}
