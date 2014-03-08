package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StatsUpgradeResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StatsUpgradeResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5609;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var nbCharacBoost:uint = 0;
      
      override public function getMessageId() : uint {
         return 5609;
      }
      
      public function initStatsUpgradeResultMessage(nbCharacBoost:uint=0) : StatsUpgradeResultMessage {
         this.nbCharacBoost = nbCharacBoost;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.nbCharacBoost = 0;
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
         this.serializeAs_StatsUpgradeResultMessage(output);
      }
      
      public function serializeAs_StatsUpgradeResultMessage(output:IDataOutput) : void {
         if(this.nbCharacBoost < 0)
         {
            throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element nbCharacBoost.");
         }
         else
         {
            output.writeShort(this.nbCharacBoost);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StatsUpgradeResultMessage(input);
      }
      
      public function deserializeAs_StatsUpgradeResultMessage(input:IDataInput) : void {
         this.nbCharacBoost = input.readShort();
         if(this.nbCharacBoost < 0)
         {
            throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element of StatsUpgradeResultMessage.nbCharacBoost.");
         }
         else
         {
            return;
         }
      }
   }
}
