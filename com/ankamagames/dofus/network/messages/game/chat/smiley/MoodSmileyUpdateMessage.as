package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MoodSmileyUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MoodSmileyUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6388;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var accountId:uint = 0;
      
      public var playerId:uint = 0;
      
      public var smileyId:int = 0;
      
      override public function getMessageId() : uint {
         return 6388;
      }
      
      public function initMoodSmileyUpdateMessage(param1:uint=0, param2:uint=0, param3:int=0) : MoodSmileyUpdateMessage {
         this.accountId = param1;
         this.playerId = param2;
         this.smileyId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accountId = 0;
         this.playerId = 0;
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
         this.serializeAs_MoodSmileyUpdateMessage(param1);
      }
      
      public function serializeAs_MoodSmileyUpdateMessage(param1:IDataOutput) : void {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               param1.writeInt(this.playerId);
               param1.writeByte(this.smileyId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MoodSmileyUpdateMessage(param1);
      }
      
      public function deserializeAs_MoodSmileyUpdateMessage(param1:IDataInput) : void {
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of MoodSmileyUpdateMessage.accountId.");
         }
         else
         {
            this.playerId = param1.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of MoodSmileyUpdateMessage.playerId.");
            }
            else
            {
               this.smileyId = param1.readByte();
               return;
            }
         }
      }
   }
}
