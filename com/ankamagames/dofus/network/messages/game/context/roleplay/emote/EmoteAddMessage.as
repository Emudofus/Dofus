package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class EmoteAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function EmoteAddMessage() {
         super();
      }
      
      public static const protocolId:uint = 5644;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var emoteId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5644;
      }
      
      public function initEmoteAddMessage(emoteId:uint = 0) : EmoteAddMessage {
         this.emoteId = emoteId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.emoteId = 0;
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
         this.serializeAs_EmoteAddMessage(output);
      }
      
      public function serializeAs_EmoteAddMessage(output:IDataOutput) : void {
         if((this.emoteId < 0) || (this.emoteId > 255))
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         else
         {
            output.writeByte(this.emoteId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_EmoteAddMessage(input);
      }
      
      public function deserializeAs_EmoteAddMessage(input:IDataInput) : void {
         this.emoteId = input.readUnsignedByte();
         if((this.emoteId < 0) || (this.emoteId > 255))
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of EmoteAddMessage.emoteId.");
         }
         else
         {
            return;
         }
      }
   }
}
