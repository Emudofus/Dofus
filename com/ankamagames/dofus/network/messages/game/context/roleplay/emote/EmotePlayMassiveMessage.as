package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initEmotePlayMassiveMessage(param1:uint=0, param2:Number=0, param3:Vector.<int>=null) : EmotePlayMassiveMessage {
         super.initEmotePlayAbstractMessage(param1,param2);
         this.actorIds = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.actorIds = new Vector.<int>();
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
         this.serializeAs_EmotePlayMassiveMessage(param1);
      }
      
      public function serializeAs_EmotePlayMassiveMessage(param1:IDataOutput) : void {
         super.serializeAs_EmotePlayAbstractMessage(param1);
         param1.writeShort(this.actorIds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.actorIds.length)
         {
            param1.writeInt(this.actorIds[_loc2_]);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_EmotePlayMassiveMessage(param1);
      }
      
      public function deserializeAs_EmotePlayMassiveMessage(param1:IDataInput) : void {
         var _loc4_:* = 0;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInt();
            this.actorIds.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
