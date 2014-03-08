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
      
      public function initObjectUseOnCharacterMessage(param1:uint=0, param2:uint=0) : ObjectUseOnCharacterMessage {
         super.initObjectUseMessage(param1);
         this.characterId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.characterId = 0;
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
         this.serializeAs_ObjectUseOnCharacterMessage(param1);
      }
      
      public function serializeAs_ObjectUseOnCharacterMessage(param1:IDataOutput) : void {
         super.serializeAs_ObjectUseMessage(param1);
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         else
         {
            param1.writeInt(this.characterId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectUseOnCharacterMessage(param1);
      }
      
      public function deserializeAs_ObjectUseOnCharacterMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.characterId = param1.readInt();
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
