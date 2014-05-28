package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectionWithRenameMessage extends CharacterSelectionMessage implements INetworkMessage
   {
      
      public function CharacterSelectionWithRenameMessage() {
         super();
      }
      
      public static const protocolId:uint = 6121;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 6121;
      }
      
      public function initCharacterSelectionWithRenameMessage(id:int = 0, name:String = "") : CharacterSelectionWithRenameMessage {
         super.initCharacterSelectionMessage(id);
         this.name = name;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
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
         this.serializeAs_CharacterSelectionWithRenameMessage(output);
      }
      
      public function serializeAs_CharacterSelectionWithRenameMessage(output:IDataOutput) : void {
         super.serializeAs_CharacterSelectionMessage(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSelectionWithRenameMessage(input);
      }
      
      public function deserializeAs_CharacterSelectionWithRenameMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.name = input.readUTF();
      }
   }
}
