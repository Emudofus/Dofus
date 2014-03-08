package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class EmotePlayMassiveMessage extends EmotePlayAbstractMessage implements INetworkMessage
   {
      
      public function EmotePlayMassiveMessage() {
         this.actorIds = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 5691;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var actorIds:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 5691;
      }
      
      public function initEmotePlayMassiveMessage(emoteId:uint=0, emoteStartTime:Number=0, actorIds:Vector.<int>=null) : EmotePlayMassiveMessage {
         super.initEmotePlayAbstractMessage(emoteId,emoteStartTime);
         this.actorIds = actorIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.actorIds = new Vector.<int>();
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
         this.serializeAs_EmotePlayMassiveMessage(output);
      }
      
      public function serializeAs_EmotePlayMassiveMessage(output:IDataOutput) : void {
         super.serializeAs_EmotePlayAbstractMessage(output);
         output.writeShort(this.actorIds.length);
         var _i1:uint = 0;
         while(_i1 < this.actorIds.length)
         {
            output.writeInt(this.actorIds[_i1]);
            _i1++;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_EmotePlayMassiveMessage(input);
      }
      
      public function deserializeAs_EmotePlayMassiveMessage(input:IDataInput) : void {
         var _val1:* = 0;
         super.deserialize(input);
         var _actorIdsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _actorIdsLen)
         {
            _val1 = input.readInt();
            this.actorIds.push(_val1);
            _i1++;
         }
      }
   }
}
