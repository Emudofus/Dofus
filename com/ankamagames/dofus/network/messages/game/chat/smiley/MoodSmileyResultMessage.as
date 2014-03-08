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
      
      public function initMoodSmileyResultMessage(param1:uint=1, param2:int=0) : MoodSmileyResultMessage {
         this.resultCode = param1;
         this.smileyId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.resultCode = 1;
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
         this.serializeAs_MoodSmileyResultMessage(param1);
      }
      
      public function serializeAs_MoodSmileyResultMessage(param1:IDataOutput) : void {
         param1.writeByte(this.resultCode);
         param1.writeByte(this.smileyId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MoodSmileyResultMessage(param1);
      }
      
      public function deserializeAs_MoodSmileyResultMessage(param1:IDataInput) : void {
         this.resultCode = param1.readByte();
         if(this.resultCode < 0)
         {
            throw new Error("Forbidden value (" + this.resultCode + ") on element of MoodSmileyResultMessage.resultCode.");
         }
         else
         {
            this.smileyId = param1.readByte();
            return;
         }
      }
   }
}
