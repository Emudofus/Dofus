package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectionWithRelookMessage extends CharacterSelectionMessage implements INetworkMessage
   {
      
      public function CharacterSelectionWithRelookMessage() {
         super();
      }
      
      public static const protocolId:uint = 6353;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var cosmeticId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6353;
      }
      
      public function initCharacterSelectionWithRelookMessage(id:int = 0, cosmeticId:uint = 0) : CharacterSelectionWithRelookMessage {
         super.initCharacterSelectionMessage(id);
         this.cosmeticId = cosmeticId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.cosmeticId = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterSelectionWithRelookMessage(output);
      }
      
      public function serializeAs_CharacterSelectionWithRelookMessage(output:IDataOutput) : void {
         super.serializeAs_CharacterSelectionMessage(output);
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         else
         {
            output.writeInt(this.cosmeticId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSelectionWithRelookMessage(input);
      }
      
      public function deserializeAs_CharacterSelectionWithRelookMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.cosmeticId = input.readInt();
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterSelectionWithRelookMessage.cosmeticId.");
         }
         else
         {
            return;
         }
      }
   }
}
