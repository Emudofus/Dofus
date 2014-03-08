package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountEmoteIconUsedOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountEmoteIconUsedOkMessage() {
         super();
      }
      
      public static const protocolId:uint = 5978;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountId:int = 0;
      
      public var reactionType:uint = 0;
      
      override public function getMessageId() : uint {
         return 5978;
      }
      
      public function initMountEmoteIconUsedOkMessage(param1:int=0, param2:uint=0) : MountEmoteIconUsedOkMessage {
         this.mountId = param1;
         this.reactionType = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountId = 0;
         this.reactionType = 0;
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
         this.serializeAs_MountEmoteIconUsedOkMessage(param1);
      }
      
      public function serializeAs_MountEmoteIconUsedOkMessage(param1:IDataOutput) : void {
         param1.writeInt(this.mountId);
         if(this.reactionType < 0)
         {
            throw new Error("Forbidden value (" + this.reactionType + ") on element reactionType.");
         }
         else
         {
            param1.writeByte(this.reactionType);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MountEmoteIconUsedOkMessage(param1);
      }
      
      public function deserializeAs_MountEmoteIconUsedOkMessage(param1:IDataInput) : void {
         this.mountId = param1.readInt();
         this.reactionType = param1.readByte();
         if(this.reactionType < 0)
         {
            throw new Error("Forbidden value (" + this.reactionType + ") on element of MountEmoteIconUsedOkMessage.reactionType.");
         }
         else
         {
            return;
         }
      }
   }
}
