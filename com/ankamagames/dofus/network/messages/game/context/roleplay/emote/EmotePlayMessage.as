package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class EmotePlayMessage extends EmotePlayAbstractMessage implements INetworkMessage
   {
      
      public function EmotePlayMessage() {
         super();
      }
      
      public static const protocolId:uint = 5683;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var actorId:int = 0;
      
      public var accountId:int = 0;
      
      override public function getMessageId() : uint {
         return 5683;
      }
      
      public function initEmotePlayMessage(emoteId:uint=0, emoteStartTime:Number=0, actorId:int=0, accountId:int=0) : EmotePlayMessage {
         super.initEmotePlayAbstractMessage(emoteId,emoteStartTime);
         this.actorId = actorId;
         this.accountId = accountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.actorId = 0;
         this.accountId = 0;
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
         this.serializeAs_EmotePlayMessage(output);
      }
      
      public function serializeAs_EmotePlayMessage(output:IDataOutput) : void {
         super.serializeAs_EmotePlayAbstractMessage(output);
         output.writeInt(this.actorId);
         output.writeInt(this.accountId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_EmotePlayMessage(input);
      }
      
      public function deserializeAs_EmotePlayMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.actorId = input.readInt();
         this.accountId = input.readInt();
      }
   }
}
