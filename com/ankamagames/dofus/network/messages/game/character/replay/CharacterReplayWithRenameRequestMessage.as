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
      
      public function initCharacterReplayWithRenameRequestMessage(param1:uint=0, param2:String="") : CharacterReplayWithRenameRequestMessage {
         super.initCharacterReplayRequestMessage(param1);
         this.name = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
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
         this.serializeAs_CharacterReplayWithRenameRequestMessage(param1);
      }
      
      public function serializeAs_CharacterReplayWithRenameRequestMessage(param1:IDataOutput) : void {
         super.serializeAs_CharacterReplayRequestMessage(param1);
         param1.writeUTF(this.name);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterReplayWithRenameRequestMessage(param1);
      }
      
      public function deserializeAs_CharacterReplayWithRenameRequestMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.name = param1.readUTF();
      }
   }
}
