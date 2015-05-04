package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MapCoordinatesExtended extends MapCoordinatesAndId implements INetworkType
   {
      
      public function MapCoordinatesExtended()
      {
         super();
      }
      
      public static const protocolId:uint = 176;
      
      public var subAreaId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 176;
      }
      
      public function initMapCoordinatesExtended(param1:int = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : MapCoordinatesExtended
      {
         super.initMapCoordinatesAndId(param1,param2,param3);
         this.subAreaId = param4;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.subAreaId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MapCoordinatesExtended(param1);
      }
      
      public function serializeAs_MapCoordinatesExtended(param1:ICustomDataOutput) : void
      {
         super.serializeAs_MapCoordinatesAndId(param1);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeVarShort(this.subAreaId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MapCoordinatesExtended(param1);
      }
      
      public function deserializeAs_MapCoordinatesExtended(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.subAreaId = param1.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of MapCoordinatesExtended.subAreaId.");
         }
         else
         {
            return;
         }
      }
   }
}
