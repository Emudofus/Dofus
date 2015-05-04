package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class EntityMovementInformations extends Object implements INetworkType
   {
      
      public function EntityMovementInformations()
      {
         this.steps = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 63;
      
      public var id:int = 0;
      
      public var steps:Vector.<int>;
      
      public function getTypeId() : uint
      {
         return 63;
      }
      
      public function initEntityMovementInformations(param1:int = 0, param2:Vector.<int> = null) : EntityMovementInformations
      {
         this.id = param1;
         this.steps = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.steps = new Vector.<int>();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_EntityMovementInformations(param1);
      }
      
      public function serializeAs_EntityMovementInformations(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.id);
         param1.writeShort(this.steps.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.steps.length)
         {
            param1.writeByte(this.steps[_loc2_]);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_EntityMovementInformations(param1);
      }
      
      public function deserializeAs_EntityMovementInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:* = 0;
         this.id = param1.readInt();
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readByte();
            this.steps.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
