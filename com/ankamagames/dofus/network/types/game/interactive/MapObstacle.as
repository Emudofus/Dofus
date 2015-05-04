package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MapObstacle extends Object implements INetworkType
   {
      
      public function MapObstacle()
      {
         super();
      }
      
      public static const protocolId:uint = 200;
      
      public var obstacleCellId:uint = 0;
      
      public var state:uint = 0;
      
      public function getTypeId() : uint
      {
         return 200;
      }
      
      public function initMapObstacle(param1:uint = 0, param2:uint = 0) : MapObstacle
      {
         this.obstacleCellId = param1;
         this.state = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.obstacleCellId = 0;
         this.state = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MapObstacle(param1);
      }
      
      public function serializeAs_MapObstacle(param1:ICustomDataOutput) : void
      {
         if(this.obstacleCellId < 0 || this.obstacleCellId > 559)
         {
            throw new Error("Forbidden value (" + this.obstacleCellId + ") on element obstacleCellId.");
         }
         else
         {
            param1.writeVarShort(this.obstacleCellId);
            param1.writeByte(this.state);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MapObstacle(param1);
      }
      
      public function deserializeAs_MapObstacle(param1:ICustomDataInput) : void
      {
         this.obstacleCellId = param1.readVarUhShort();
         if(this.obstacleCellId < 0 || this.obstacleCellId > 559)
         {
            throw new Error("Forbidden value (" + this.obstacleCellId + ") on element of MapObstacle.obstacleCellId.");
         }
         else
         {
            this.state = param1.readByte();
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
