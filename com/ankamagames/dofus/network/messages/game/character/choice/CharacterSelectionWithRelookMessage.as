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
      
      public function initCharacterSelectionWithRelookMessage(param1:int=0, param2:uint=0) : CharacterSelectionWithRelookMessage {
         super.initCharacterSelectionMessage(param1);
         this.cosmeticId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.cosmeticId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterSelectionWithRelookMessage(param1);
      }
      
      public function serializeAs_CharacterSelectionWithRelookMessage(param1:IDataOutput) : void {
         super.serializeAs_CharacterSelectionMessage(param1);
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         else
         {
            param1.writeInt(this.cosmeticId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterSelectionWithRelookMessage(param1);
      }
      
      public function deserializeAs_CharacterSelectionWithRelookMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.cosmeticId = param1.readInt();
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
