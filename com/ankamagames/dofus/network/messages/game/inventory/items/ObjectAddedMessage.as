package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectAddedMessage()
      {
         this.object = new ObjectItem();
         super();
      }
      
      public static const protocolId:uint = 3025;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var object:ObjectItem;
      
      override public function getMessageId() : uint
      {
         return 3025;
      }
      
      public function initObjectAddedMessage(param1:ObjectItem = null) : ObjectAddedMessage
      {
         this.object = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.object = new ObjectItem();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectAddedMessage(param1);
      }
      
      public function serializeAs_ObjectAddedMessage(param1:ICustomDataOutput) : void
      {
         this.object.serializeAs_ObjectItem(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectAddedMessage(param1);
      }
      
      public function deserializeAs_ObjectAddedMessage(param1:ICustomDataInput) : void
      {
         this.object = new ObjectItem();
         this.object.deserialize(param1);
      }
   }
}
