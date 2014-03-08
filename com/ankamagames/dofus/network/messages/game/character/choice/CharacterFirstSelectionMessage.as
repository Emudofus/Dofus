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
      
      public function initCharacterFirstSelectionMessage(param1:int=0, param2:Boolean=false) : CharacterFirstSelectionMessage {
         super.initCharacterSelectionMessage(param1);
         this.doTutorial = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.doTutorial = false;
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
         this.serializeAs_CharacterFirstSelectionMessage(param1);
      }
      
      public function serializeAs_CharacterFirstSelectionMessage(param1:IDataOutput) : void {
         super.serializeAs_CharacterSelectionMessage(param1);
         param1.writeBoolean(this.doTutorial);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterFirstSelectionMessage(param1);
      }
      
      public function deserializeAs_CharacterFirstSelectionMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.doTutorial = param1.readBoolean();
      }
   }
}
