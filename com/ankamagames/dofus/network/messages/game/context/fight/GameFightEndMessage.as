package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameFightEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightEndMessage() {
         this.results = new Vector.<FightResultListEntry>();
         super();
      }
      
      public static const protocolId:uint = 720;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var duration:uint = 0;
      
      public var ageBonus:int = 0;
      
      public var lootShareLimitMalus:int = 0;
      
      public var results:Vector.<FightResultListEntry>;
      
      override public function getMessageId() : uint {
         return 720;
      }
      
      public function initGameFightEndMessage(param1:uint=0, param2:int=0, param3:int=0, param4:Vector.<FightResultListEntry>=null) : GameFightEndMessage {
         this.duration = param1;
         this.ageBonus = param2;
         this.lootShareLimitMalus = param3;
         this.results = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.duration = 0;
         this.ageBonus = 0;
         this.lootShareLimitMalus = 0;
         this.results = new Vector.<FightResultListEntry>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightEndMessage(param1);
      }
      
      public function serializeAs_GameFightEndMessage(param1:IDataOutput) : void {
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element duration.");
         }
         else
         {
            param1.writeInt(this.duration);
            param1.writeShort(this.ageBonus);
            param1.writeShort(this.lootShareLimitMalus);
            param1.writeShort(this.results.length);
            _loc2_ = 0;
            while(_loc2_ < this.results.length)
            {
               param1.writeShort((this.results[_loc2_] as FightResultListEntry).getTypeId());
               (this.results[_loc2_] as FightResultListEntry).serialize(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightEndMessage(param1);
      }
      
      public function deserializeAs_GameFightEndMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:FightResultListEntry = null;
         this.duration = param1.readInt();
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element of GameFightEndMessage.duration.");
         }
         else
         {
            this.ageBonus = param1.readShort();
            this.lootShareLimitMalus = param1.readShort();
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUnsignedShort();
               _loc5_ = ProtocolTypeManager.getInstance(FightResultListEntry,_loc4_);
               _loc5_.deserialize(param1);
               this.results.push(_loc5_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
