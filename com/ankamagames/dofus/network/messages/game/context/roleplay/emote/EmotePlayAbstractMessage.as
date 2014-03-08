package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class EmotePlayAbstractMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function EmotePlayAbstractMessage() {
         super();
      }
      
      public static const protocolId:uint = 5690;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var emoteId:uint = 0;
      
      public var emoteStartTime:Number = 0;
      
      override public function getMessageId() : uint {
         return 5690;
      }
      
      public function initEmotePlayAbstractMessage(param1:uint=0, param2:Number=0) : EmotePlayAbstractMessage {
         this.emoteId = param1;
         this.emoteStartTime = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.emoteId = 0;
         this.emoteStartTime = 0;
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
         this.serializeAs_EmotePlayAbstractMessage(param1);
      }
      
      public function serializeAs_EmotePlayAbstractMessage(param1:IDataOutput) : void {
         if(this.emoteId < 0 || this.emoteId > 255)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         else
         {
            param1.writeByte(this.emoteId);
            param1.writeDouble(this.emoteStartTime);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_EmotePlayAbstractMessage(param1);
      }
      
      public function deserializeAs_EmotePlayAbstractMessage(param1:IDataInput) : void {
         this.emoteId = param1.readUnsignedByte();
         if(this.emoteId < 0 || this.emoteId > 255)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of EmotePlayAbstractMessage.emoteId.");
         }
         else
         {
            this.emoteStartTime = param1.readDouble();
            return;
         }
      }
   }
}
