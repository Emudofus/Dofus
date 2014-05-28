package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MoodSmileyResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MoodSmileyResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 6196;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var resultCode:uint = 1;
      
      public var smileyId:int = 0;
      
      override public function getMessageId() : uint {
         return 6196;
      }
      
      public function initMoodSmileyResultMessage(resultCode:uint = 1, smileyId:int = 0) : MoodSmileyResultMessage {
         this.resultCode = resultCode;
         this.smileyId = smileyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.resultCode = 1;
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
         this.serializeAs_MoodSmileyResultMessage(output);
      }
      
      public function serializeAs_MoodSmileyResultMessage(output:IDataOutput) : void {
         output.writeByte(this.resultCode);
         output.writeByte(this.smileyId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MoodSmileyResultMessage(input);
      }
      
      public function deserializeAs_MoodSmileyResultMessage(input:IDataInput) : void {
         this.resultCode = input.readByte();
         if(this.resultCode < 0)
         {
            throw new Error("Forbidden value (" + this.resultCode + ") on element of MoodSmileyResultMessage.resultCode.");
         }
         else
         {
            this.smileyId = input.readByte();
            return;
         }
      }
   }
}
