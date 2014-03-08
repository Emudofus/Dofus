package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FightResultPlayerListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public function FightResultPlayerListEntry() {
         this.additional = new Vector.<FightResultAdditionalData>();
         super();
      }
      
      public static const protocolId:uint = 24;
      
      public var level:uint = 0;
      
      public var additional:Vector.<FightResultAdditionalData>;
      
      override public function getTypeId() : uint {
         return 24;
      }
      
      public function initFightResultPlayerListEntry(param1:uint=0, param2:FightLoot=null, param3:int=0, param4:Boolean=false, param5:uint=0, param6:Vector.<FightResultAdditionalData>=null) : FightResultPlayerListEntry {
         super.initFightResultFighterListEntry(param1,param2,param3,param4);
         this.level = param5;
         this.additional = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.level = 0;
         this.additional = new Vector.<FightResultAdditionalData>();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightResultPlayerListEntry(param1);
      }
      
      public function serializeAs_FightResultPlayerListEntry(param1:IDataOutput) : void {
         super.serializeAs_FightResultFighterListEntry(param1);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeByte(this.level);
            param1.writeShort(this.additional.length);
            _loc2_ = 0;
            while(_loc2_ < this.additional.length)
            {
               param1.writeShort((this.additional[_loc2_] as FightResultAdditionalData).getTypeId());
               (this.additional[_loc2_] as FightResultAdditionalData).serialize(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightResultPlayerListEntry(param1);
      }
      
      public function deserializeAs_FightResultPlayerListEntry(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:FightResultAdditionalData = null;
         super.deserialize(param1);
         this.level = param1.readUnsignedByte();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightResultPlayerListEntry.level.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUnsignedShort();
               _loc5_ = ProtocolTypeManager.getInstance(FightResultAdditionalData,_loc4_);
               _loc5_.deserialize(param1);
               this.additional.push(_loc5_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
