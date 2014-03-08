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
      
      public function initIgnoredAddedMessage(ignoreAdded:IgnoredInformations=null, session:Boolean=false) : IgnoredAddedMessage {
         this.ignoreAdded = ignoreAdded;
         this.session = session;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ignoreAdded = new IgnoredInformations();
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
         this.serializeAs_IgnoredAddedMessage(output);
      }
      
      public function serializeAs_IgnoredAddedMessage(output:IDataOutput) : void {
         output.writeShort(this.ignoreAdded.getTypeId());
         this.ignoreAdded.serialize(output);
         output.writeBoolean(this.session);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IgnoredAddedMessage(input);
      }
      
      public function deserializeAs_IgnoredAddedMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.ignoreAdded = ProtocolTypeManager.getInstance(IgnoredInformations,_id1);
         this.ignoreAdded.deserialize(input);
         this.session = input.readBoolean();
      }
   }
}
