package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StatsUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StatsUpgradeRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5610;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var statId:uint = 11;
      
      public var boostPoint:uint = 0;
      
      override public function getMessageId() : uint {
         return 5610;
      }
      
      public function initStatsUpgradeRequestMessage(param1:uint=11, param2:uint=0) : StatsUpgradeRequestMessage {
         this.statId = param1;
         this.boostPoint = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.statId = 11;
         this.boostPoint = 0;
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
         this.serializeAs_StatsUpgradeRequestMessage(param1);
      }
      
      public function serializeAs_StatsUpgradeRequestMessage(param1:IDataOutput) : void {
         param1.writeByte(this.statId);
         if(this.boostPoint < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoint + ") on element boostPoint.");
         }
         else
         {
            param1.writeShort(this.boostPoint);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_StatsUpgradeRequestMessage(param1);
      }
      
      public function deserializeAs_StatsUpgradeRequestMessage(param1:IDataInput) : void {
         this.statId = param1.readByte();
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of StatsUpgradeRequestMessage.statId.");
         }
         else
         {
            this.boostPoint = param1.readShort();
            if(this.boostPoint < 0)
            {
               throw new Error("Forbidden value (" + this.boostPoint + ") on element of StatsUpgradeRequestMessage.boostPoint.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
