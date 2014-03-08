package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectedErrorMissingMapPackMessage extends CharacterSelectedErrorMessage implements INetworkMessage
   {
      
      public function CharacterSelectedErrorMissingMapPackMessage() {
         super();
      }
      
      public static const protocolId:uint = 6300;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var subAreaId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6300;
      }
      
      public function initCharacterSelectedErrorMissingMapPackMessage(param1:uint=0) : CharacterSelectedErrorMissingMapPackMessage {
         this.subAreaId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
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
         this.serializeAs_CharacterSelectedErrorMissingMapPackMessage(param1);
      }
      
      public function serializeAs_CharacterSelectedErrorMissingMapPackMessage(param1:IDataOutput) : void {
         super.serializeAs_CharacterSelectedErrorMessage(param1);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeInt(this.subAreaId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterSelectedErrorMissingMapPackMessage(param1);
      }
      
      public function deserializeAs_CharacterSelectedErrorMissingMapPackMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.subAreaId = param1.readInt();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of CharacterSelectedErrorMissingMapPackMessage.subAreaId.");
         }
         else
         {
            return;
         }
      }
   }
}
