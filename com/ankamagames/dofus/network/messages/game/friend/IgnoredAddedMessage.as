package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class IgnoredAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredAddedMessage() {
         this.ignoreAdded = new IgnoredInformations();
         super();
      }
      
      public static const protocolId:uint = 5678;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ignoreAdded:IgnoredInformations;
      
      public var session:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5678;
      }
      
      public function initIgnoredAddedMessage(param1:IgnoredInformations=null, param2:Boolean=false) : IgnoredAddedMessage {
         this.ignoreAdded = param1;
         this.session = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ignoreAdded = new IgnoredInformations();
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
         this.serializeAs_IgnoredAddedMessage(param1);
      }
      
      public function serializeAs_IgnoredAddedMessage(param1:IDataOutput) : void {
         param1.writeShort(this.ignoreAdded.getTypeId());
         this.ignoreAdded.serialize(param1);
         param1.writeBoolean(this.session);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IgnoredAddedMessage(param1);
      }
      
      public function deserializeAs_IgnoredAddedMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readUnsignedShort();
         this.ignoreAdded = ProtocolTypeManager.getInstance(IgnoredInformations,_loc2_);
         this.ignoreAdded.deserialize(param1);
         this.session = param1.readBoolean();
      }
   }
}
