package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class MapObstacle extends Object implements INetworkType
   {
      
      public function MapObstacle() {
         super();
      }
      
      public static const protocolId:uint = 200;
      
      public var obstacleCellId:uint = 0;
      
      public var state:uint = 0;
      
      public function getTypeId() : uint {
         return 200;
      }
      
      public function initMapObstacle(obstacleCellId:uint=0, state:uint=0) : MapObstacle {
         this.obstacleCellId = obstacleCellId;
         this.state = state;
         return this;
      }
      
      public function reset() : void {
         this.obstacleCellId = 0;
         this.state = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MapObstacle(output);
      }
      
      public function serializeAs_MapObstacle(output:IDataOutput) : void {
         if((this.obstacleCellId < 0) || (this.obstacleCellId > 559))
         {
            throw new Error("Forbidden value (" + this.obstacleCellId + ") on element obstacleCellId.");
         }
         else
         {
            output.writeShort(this.obstacleCellId);
            output.writeByte(this.state);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapObstacle(input);
      }
      
      public function deserializeAs_MapObstacle(input:IDataInput) : void {
         this.obstacleCellId = input.readShort();
         if((this.obstacleCellId < 0) || (this.obstacleCellId > 559))
         {
            throw new Error("Forbidden value (" + this.obstacleCellId + ") on element of MapObstacle.obstacleCellId.");
         }
         else
         {
            this.state = input.readByte();
            if(this.state < 0)
            {
               throw new Error("Forbidden value (" + this.state + ") on element of MapObstacle.state.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
