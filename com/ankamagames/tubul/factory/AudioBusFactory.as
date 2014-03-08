package com.ankamagames.tubul.factory
{
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.tubul.types.bus.LocalizedBus;
   import com.ankamagames.tubul.types.bus.UnlocalizedBus;
   import com.ankamagames.tubul.enum.EnumTypeBus;
   
   public class AudioBusFactory extends Object
   {
      
      public function AudioBusFactory() {
         super();
      }
      
      public static function getAudioBus(param1:uint, param2:uint, param3:String) : IAudioBus {
         switch(param1)
         {
            case EnumTypeBus.LOCALIZED_BUS:
               return new LocalizedBus(param2,param3);
            case EnumTypeBus.UNLOCALIZED_BUS:
               return new UnlocalizedBus(param2,param3);
            default:
               throw new ArgumentError("Unknown audio bus type " + param1 + ". See EnumTypeBus !");
         }
      }
   }
}
