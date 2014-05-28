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
      
      public function initStatsUpgradeRequestMessage(statId:uint = 11, boostPoint:uint = 0) : StatsUpgradeRequestMessage {
         this.statId = statId;
         this.boostPoint = boostPoint;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.statId = 11;
         this.boostPoint = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_StatsUpgradeRequestMessage(output);
      }
      
      public function serializeAs_StatsUpgradeRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.statId);
         if(this.boostPoint < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoint + ") on element boostPoint.");
         }
         else
         {
            output.writeShort(this.boostPoint);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StatsUpgradeRequestMessage(input);
      }
      
      public function deserializeAs_StatsUpgradeRequestMessage(input:IDataInput) : void {
         this.statId = input.readByte();
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of StatsUpgradeRequestMessage.statId.");
         }
         else
         {
            this.boostPoint = input.readShort();
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
