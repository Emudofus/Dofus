package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterSelectionMessage() {
         super();
      }
      
      public static const protocolId:uint = 152;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      override public function getMessageId() : uint {
         return 152;
      }
      
      public function initCharacterSelectionMessage(id:int = 0) : CharacterSelectionMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_CharacterSelectionMessage(output);
      }
      
      public function serializeAs_CharacterSelectionMessage(output:IDataOutput) : void {
         if((this.id < 1) || (this.id > 2147483647))
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSelectionMessage(input);
      }
      
      public function deserializeAs_CharacterSelectionMessage(input:IDataInput) : void {
         this.id = input.readInt();
         if((this.id < 1) || (this.id > 2147483647))
         {
            throw new Error("Forbidden value (" + this.id + ") on element of CharacterSelectionMessage.id.");
         }
         else
         {
            return;
         }
      }
   }
}
