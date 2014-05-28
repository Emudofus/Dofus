package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectUseOnCharacterMessage extends ObjectUseMessage implements INetworkMessage
   {
      
      public function ObjectUseOnCharacterMessage() {
         super();
      }
      
      public static const protocolId:uint = 3003;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var characterId:uint = 0;
      
      override public function getMessageId() : uint {
         return 3003;
      }
      
      public function initObjectUseOnCharacterMessage(objectUID:uint = 0, characterId:uint = 0) : ObjectUseOnCharacterMessage {
         super.initObjectUseMessage(objectUID);
         this.characterId = characterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.characterId = 0;
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
         this.serializeAs_ObjectUseOnCharacterMessage(output);
      }
      
      public function serializeAs_ObjectUseOnCharacterMessage(output:IDataOutput) : void {
         super.serializeAs_ObjectUseMessage(output);
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         else
         {
            output.writeInt(this.characterId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectUseOnCharacterMessage(input);
      }
      
      public function deserializeAs_ObjectUseOnCharacterMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.characterId = input.readInt();
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of ObjectUseOnCharacterMessage.characterId.");
         }
         else
         {
            return;
         }
      }
   }
}
