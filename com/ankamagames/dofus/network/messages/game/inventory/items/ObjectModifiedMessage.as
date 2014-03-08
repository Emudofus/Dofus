package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectModifiedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectModifiedMessage() {
         this.object = new ObjectItem();
         super();
      }
      
      public static const protocolId:uint = 3029;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var object:ObjectItem;
      
      override public function getMessageId() : uint {
         return 3029;
      }
      
      public function initObjectModifiedMessage(object:ObjectItem=null) : ObjectModifiedMessage {
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
         this.serializeAs_ObjectModifiedMessage(output);
      }
      
      public function serializeAs_ObjectModifiedMessage(output:IDataOutput) : void {
         this.object.serializeAs_ObjectItem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectModifiedMessage(input);
      }
      
      public function deserializeAs_ObjectModifiedMessage(input:IDataInput) : void {
         this.object = new ObjectItem();
         this.object.deserialize(input);
      }
   }
}
