package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MimicryObjectPreviewMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MimicryObjectPreviewMessage() {
         this.result = new ObjectItem();
         super();
      }
      
      public static const protocolId:uint = 6458;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var result:ObjectItem;
      
      override public function getMessageId() : uint {
         return 6458;
      }
      
      public function initMimicryObjectPreviewMessage(param1:ObjectItem=null) : MimicryObjectPreviewMessage {
         this.result = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.result = new ObjectItem();
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
         this.serializeAs_MimicryObjectPreviewMessage(param1);
      }
      
      public function serializeAs_MimicryObjectPreviewMessage(param1:IDataOutput) : void {
         this.result.serializeAs_ObjectItem(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MimicryObjectPreviewMessage(param1);
      }
      
      public function deserializeAs_MimicryObjectPreviewMessage(param1:IDataInput) : void {
         this.result = new ObjectItem();
         this.result.deserialize(param1);
      }
   }
}
