package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MapCoordinatesAndId extends MapCoordinates implements INetworkType
   {
      
      public function MapCoordinatesAndId()
      {
         super();
      }
      
      public static const protocolId:uint = 392;
      
      public var mapId:int = 0;
      
      override public function getTypeId() : uint
      {
         return 392;
      }
      
      public function initMapCoordinatesAndId(param1:int = 0, param2:int = 0, param3:int = 0) : MapCoordinatesAndId
      {
         super.initMapCoordinates(param1,param2);
         this.mapId = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.mapId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MapCoordinatesAndId(param1);
      }
      
      public function serializeAs_MapCoordinatesAndId(param1:ICustomDataOutput) : void
      {
         super.serializeAs_MapCoordinates(param1);
         param1.writeInt(this.mapId);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MapCoordinatesAndId(param1);
      }
      
      public function deserializeAs_MapCoordinatesAndId(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.mapId = param1.readInt();
      }
   }
}
