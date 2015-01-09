package com.ankamagames.tubul.factory
{
    import com.ankamagames.tubul.types.bus.LocalizedBus;
    import com.ankamagames.tubul.enum.EnumTypeBus;
    import com.ankamagames.tubul.types.bus.UnlocalizedBus;
    import com.ankamagames.tubul.interfaces.IAudioBus;

    public class AudioBusFactory 
    {


        public static function getAudioBus(pType:uint, pId:uint, pName:String):IAudioBus
        {
            switch (pType)
            {
                case EnumTypeBus.LOCALIZED_BUS:
                    return (new LocalizedBus(pId, pName));
                case EnumTypeBus.UNLOCALIZED_BUS:
                    return (new UnlocalizedBus(pId, pName));
            };
            throw (new ArgumentError((("Unknown audio bus type " + pType) + ". See EnumTypeBus !")));
        }


    }
}//package com.ankamagames.tubul.factory

