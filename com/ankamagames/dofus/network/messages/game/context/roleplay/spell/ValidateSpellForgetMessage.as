package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ValidateSpellForgetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ValidateSpellForgetMessage() {
         super();
      }
      
      public static const protocolId:uint = 1700;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 1700;
      }
      
      public function initValidateSpellForgetMessage(spellId:uint = 0) : ValidateSpellForgetMessage {
         this.spellId = spellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellId = 0;
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
         this.serializeAs_ValidateSpellForgetMessage(output);
      }
      
      public function serializeAs_ValidateSpellForgetMessage(output:IDataOutput) : void {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            output.writeShort(this.spellId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ValidateSpellForgetMessage(input);
      }
      
      public function deserializeAs_ValidateSpellForgetMessage(input:IDataInput) : void {
         this.spellId = input.readShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of ValidateSpellForgetMessage.spellId.");
         }
         else
         {
            return;
         }
      }
   }
}
