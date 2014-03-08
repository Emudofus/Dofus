package com.ankamagames.dofus.network.messages.game.character.deletion
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterDeletionErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterDeletionErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 166;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 1;
      
      override public function getMessageId() : uint {
         return 166;
      }
      
      public function initCharacterDeletionErrorMessage(reason:uint=1) : CharacterDeletionErrorMessage {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 1;
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
         this.serializeAs_CharacterDeletionErrorMessage(output);
      }
      
      public function serializeAs_CharacterDeletionErrorMessage(output:IDataOutput) : void {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterDeletionErrorMessage(input);
      }
      
      public function deserializeAs_CharacterDeletionErrorMessage(input:IDataInput) : void {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of CharacterDeletionErrorMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
