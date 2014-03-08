package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterFirstSelectionMessage extends CharacterSelectionMessage implements INetworkMessage
   {
      
      public function CharacterFirstSelectionMessage() {
         super();
      }
      
      public static const protocolId:uint = 6084;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var doTutorial:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6084;
      }
      
      public function initCharacterFirstSelectionMessage(id:int=0, doTutorial:Boolean=false) : CharacterFirstSelectionMessage {
         super.initCharacterSelectionMessage(id);
         this.doTutorial = doTutorial;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.doTutorial = false;
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
         this.serializeAs_CharacterFirstSelectionMessage(output);
      }
      
      public function serializeAs_CharacterFirstSelectionMessage(output:IDataOutput) : void {
         super.serializeAs_CharacterSelectionMessage(output);
         output.writeBoolean(this.doTutorial);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterFirstSelectionMessage(input);
      }
      
      public function deserializeAs_CharacterFirstSelectionMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.doTutorial = input.readBoolean();
      }
   }
}
