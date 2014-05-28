package com.ankamagames.dofus.network.messages.game.character.replay
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterReplayWithRenameRequestMessage extends CharacterReplayRequestMessage implements INetworkMessage
   {
      
      public function CharacterReplayWithRenameRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6122;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 6122;
      }
      
      public function initCharacterReplayWithRenameRequestMessage(characterId:uint = 0, name:String = "") : CharacterReplayWithRenameRequestMessage {
         super.initCharacterReplayRequestMessage(characterId);
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
         this.serializeAs_CharacterReplayWithRenameRequestMessage(output);
      }
      
      public function serializeAs_CharacterReplayWithRenameRequestMessage(output:IDataOutput) : void {
         super.serializeAs_CharacterReplayRequestMessage(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterReplayWithRenameRequestMessage(input);
      }
      
      public function deserializeAs_CharacterReplayWithRenameRequestMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.name = input.readUTF();
      }
   }
}
