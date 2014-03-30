package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TreasureHuntGiveUpRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntGiveUpRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6487;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questType:uint = 0;
      
      override public function getMessageId() : uint {
         return 6487;
      }
      
      public function initTreasureHuntGiveUpRequestMessage(questType:uint=0) : TreasureHuntGiveUpRequestMessage {
         this.questType = questType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questType = 0;
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
         this.serializeAs_TreasureHuntGiveUpRequestMessage(output);
      }
      
      public function serializeAs_TreasureHuntGiveUpRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.questType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TreasureHuntGiveUpRequestMessage(input);
      }
      
      public function deserializeAs_TreasureHuntGiveUpRequestMessage(input:IDataInput) : void {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntGiveUpRequestMessage.questType.");
         }
         else
         {
            return;
         }
      }
   }
}
