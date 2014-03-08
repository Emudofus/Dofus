package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class MapCoordinatesExtended extends MapCoordinatesAndId implements INetworkType
   {
      
      public function MapCoordinatesExtended() {
         super();
      }
      
      public static const protocolId:uint = 176;
      
      public var subAreaId:uint = 0;
      
      override public function getTypeId() : uint {
         return 176;
      }
      
      public function initMapCoordinatesExtended(worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0) : MapCoordinatesExtended {
         super.initMapCoordinatesAndId(worldX,worldY,mapId);
         this.subAreaId = subAreaId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.subAreaId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_MapCoordinatesExtended(output);
      }
      
      public function serializeAs_MapCoordinatesExtended(output:IDataOutput) : void {
         super.serializeAs_MapCoordinatesAndId(output);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapCoordinatesExtended(input);
      }
      
      public function deserializeAs_MapCoordinatesExtended(input:IDataInput) : void {
         super.deserialize(input);
         this.subAreaId = input.readShort();
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
