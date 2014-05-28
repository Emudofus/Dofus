package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TreasureHuntAvailableRetryCountUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntAvailableRetryCountUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6491;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questType:uint = 0;
      
      public var availableRetryCount:int = 0;
      
      override public function getMessageId() : uint {
         return 6491;
      }
      
      public function initTreasureHuntAvailableRetryCountUpdateMessage(questType:uint = 0, availableRetryCount:int = 0) : TreasureHuntAvailableRetryCountUpdateMessage {
         this.questType = questType;
         this.availableRetryCount = availableRetryCount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questType = 0;
         this.availableRetryCount = 0;
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
         this.serializeAs_TreasureHuntAvailableRetryCountUpdateMessage(output);
      }
      
      public function serializeAs_TreasureHuntAvailableRetryCountUpdateMessage(output:IDataOutput) : void {
         output.writeByte(this.questType);
         output.writeInt(this.availableRetryCount);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TreasureHuntAvailableRetryCountUpdateMessage(input);
      }
      
      public function deserializeAs_TreasureHuntAvailableRetryCountUpdateMessage(input:IDataInput) : void {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntAvailableRetryCountUpdateMessage.questType.");
         }
         else
         {
            this.availableRetryCount = input.readInt();
            return;
         }
      }
   }
}
