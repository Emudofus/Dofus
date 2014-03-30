package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TreasureHuntRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6488;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questLevel:uint = 0;
      
      public var questType:uint = 0;
      
      override public function getMessageId() : uint {
         return 6488;
      }
      
      public function initTreasureHuntRequestMessage(questLevel:uint=0, questType:uint=0) : TreasureHuntRequestMessage {
         this.questLevel = questLevel;
         this.questType = questType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questLevel = 0;
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
         this.serializeAs_TreasureHuntRequestMessage(output);
      }
      
      public function serializeAs_TreasureHuntRequestMessage(output:IDataOutput) : void {
         if((this.questLevel < 1) || (this.questLevel > 200))
         {
            throw new Error("Forbidden value (" + this.questLevel + ") on element questLevel.");
         }
         else
         {
            output.writeByte(this.questLevel);
            output.writeByte(this.questType);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TreasureHuntRequestMessage(input);
      }
      
      public function deserializeAs_TreasureHuntRequestMessage(input:IDataInput) : void {
         this.questLevel = input.readUnsignedByte();
         if((this.questLevel < 1) || (this.questLevel > 200))
         {
            throw new Error("Forbidden value (" + this.questLevel + ") on element of TreasureHuntRequestMessage.questLevel.");
         }
         else
         {
            this.questType = input.readByte();
            if(this.questType < 0)
            {
               throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntRequestMessage.questType.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
