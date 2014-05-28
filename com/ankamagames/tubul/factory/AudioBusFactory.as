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
      
      public static function getAudioBus(pType:uint, pId:uint, pName:String) : IAudioBus {
         switch(pType)
         {
            case EnumTypeBus.LOCALIZED_BUS:
               return new LocalizedBus(pId,pName);
            case EnumTypeBus.UNLOCALIZED_BUS:
               return new UnlocalizedBus(pId,pName);
            default:
               throw new ArgumentError("Unknown audio bus type " + pType + ". See EnumTypeBus !");
         }
      }
   }
}
