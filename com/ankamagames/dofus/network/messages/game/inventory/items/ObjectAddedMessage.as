package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectAddedMessage() {
         this.object = new ObjectItem();
         super();
      }
      
      public static const protocolId:uint = 3025;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var object:ObjectItem;
      
      override public function getMessageId() : uint {
         return 3025;
      }
      
      public function initObjectAddedMessage(object:ObjectItem = null) : ObjectAddedMessage {
         this.object = object;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.object = new ObjectItem();
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
         this.serializeAs_ObjectAddedMessage(output);
      }
      
      public function serializeAs_ObjectAddedMessage(output:IDataOutput) : void {
         this.object.serializeAs_ObjectItem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectAddedMessage(input);
      }
      
      public function deserializeAs_ObjectAddedMessage(input:IDataInput) : void {
         this.object = new ObjectItem();
         this.object.deserialize(input);
      }
   }
}
