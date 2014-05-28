package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightLoot extends Object implements INetworkType
   {
      
      public function FightLoot() {
         this.objects = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 41;
      
      public var objects:Vector.<uint>;
      
      public var kamas:uint = 0;
      
      public function getTypeId() : uint {
         return 41;
      }
      
      public function initFightLoot(objects:Vector.<uint> = null, kamas:uint = 0) : FightLoot {
         this.objects = objects;
         this.kamas = kamas;
         return this;
      }
      
      public function reset() : void {
         this.objects = new Vector.<uint>();
         this.kamas = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightLoot(output);
      }
      
      public function serializeAs_FightLoot(output:IDataOutput) : void {
         output.writeShort(this.objects.length);
         var _i1:uint = 0;
         while(_i1 < this.objects.length)
         {
            if(this.objects[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.objects[_i1] + ") on element 1 (starting at 1) of objects.");
            }
            else
            {
               output.writeShort(this.objects[_i1]);
               _i1++;
               continue;
            }
         }
         if(this.kamas < 0)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         else
         {
            output.writeInt(this.kamas);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightLoot(input);
      }
      
      public function deserializeAs_FightLoot(input:IDataInput) : void {
         var _val1:uint = 0;
         var _objectsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _objectsLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of objects.");
            }
            else
            {
               this.objects.push(_val1);
               _i1++;
               continue;
            }
         }
         this.kamas = input.readInt();
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
