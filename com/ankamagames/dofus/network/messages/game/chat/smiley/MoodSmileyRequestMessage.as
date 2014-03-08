package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MoodSmileyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MoodSmileyRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6192;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var smileyId:int = 0;
      
      override public function getMessageId() : uint {
         return 6192;
      }
      
      public function initMoodSmileyRequestMessage(param1:int=0) : MoodSmileyRequestMessage {
         this.smileyId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.smileyId = 0;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_MoodSmileyRequestMessage(param1);
      }
      
      public function serializeAs_MoodSmileyRequestMessage(param1:IDataOutput) : void {
         param1.writeByte(this.smileyId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MoodSmileyRequestMessage(param1);
      }
      
      public function deserializeAs_MoodSmileyRequestMessage(param1:IDataInput) : void {
         this.smileyId = param1.readByte();
      }
   }
}
