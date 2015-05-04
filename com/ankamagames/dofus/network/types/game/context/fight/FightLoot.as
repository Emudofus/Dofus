package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FightLoot extends Object implements INetworkType
   {
      
      public function FightLoot()
      {
         this.objects = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 41;
      
      public var objects:Vector.<uint>;
      
      public var kamas:uint = 0;
      
      public function getTypeId() : uint
      {
         return 41;
      }
      
      public function initFightLoot(param1:Vector.<uint> = null, param2:uint = 0) : FightLoot
      {
         this.objects = param1;
         this.kamas = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.objects = new Vector.<uint>();
         this.kamas = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FightLoot(param1);
      }
      
      public function serializeAs_FightLoot(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.objects.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.objects.length)
         {
            if(this.objects[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.objects[_loc2_] + ") on element 1 (starting at 1) of objects.");
            }
            else
            {
               param1.writeVarShort(this.objects[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         if(this.kamas < 0)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         else
         {
            param1.writeVarInt(this.kamas);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FightLoot(param1);
      }
      
      public function deserializeAs_FightLoot(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readVarUhShort();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of objects.");
            }
            else
            {
               this.objects.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
         this.kamas = param1.readVarUhInt();
         if(this.kamas < 0)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of FightLoot.kamas.");
         }
         else
         {
            return;
         }
      }
   }
}
