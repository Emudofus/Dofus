package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class MapCoordinates extends Object implements INetworkType
   {
      
      public function MapCoordinates() {
         super();
      }
      
      public static const protocolId:uint = 174;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public function getTypeId() : uint {
         return 174;
      }
      
      public function initMapCoordinates(worldX:int = 0, worldY:int = 0) : MapCoordinates {
         this.worldX = worldX;
         this.worldY = worldY;
         return this;
      }
      
      public function reset() : void {
         this.worldX = 0;
         this.worldY = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MapCoordinates(output);
      }
      
      public function serializeAs_MapCoordinates(output:IDataOutput) : void {
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapCoordinates(input);
      }
      
      public function deserializeAs_MapCoordinates(input:IDataInput) : void {
         this.worldX = input.readShort();
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of MapCoordinates.worldX.");
         }
         else
         {
            this.worldY = input.readShort();
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of MapCoordinates.worldY.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
