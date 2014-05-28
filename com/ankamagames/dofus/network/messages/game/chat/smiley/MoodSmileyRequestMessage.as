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
      
      public function initMoodSmileyRequestMessage(smileyId:int = 0) : MoodSmileyRequestMessage {
         this.smileyId = smileyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.smileyId = 0;
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
         this.serializeAs_MoodSmileyRequestMessage(output);
      }
      
      public function serializeAs_MoodSmileyRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.smileyId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MoodSmileyRequestMessage(input);
      }
      
      public function deserializeAs_MoodSmileyRequestMessage(input:IDataInput) : void {
         this.smileyId = input.readByte();
      }
   }
}
