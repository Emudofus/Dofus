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
      
      public function initEmotePlayMessage(param1:uint=0, param2:Number=0, param3:int=0, param4:int=0) : EmotePlayMessage {
         super.initEmotePlayAbstractMessage(param1,param2);
         this.actorId = param3;
         this.accountId = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.actorId = 0;
         this.accountId = 0;
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
         this.serializeAs_EmotePlayMessage(param1);
      }
      
      public function serializeAs_EmotePlayMessage(param1:IDataOutput) : void {
         super.serializeAs_EmotePlayAbstractMessage(param1);
         param1.writeInt(this.actorId);
         param1.writeInt(this.accountId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_EmotePlayMessage(param1);
      }
      
      public function deserializeAs_EmotePlayMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.actorId = param1.readInt();
         this.accountId = param1.readInt();
      }
   }
}
