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
      
      public function initMimicryObjectPreviewMessage(result:ObjectItem=null) : MimicryObjectPreviewMessage {
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.result = new ObjectItem();
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
         this.serializeAs_MimicryObjectPreviewMessage(output);
      }
      
      public function serializeAs_MimicryObjectPreviewMessage(output:IDataOutput) : void {
         this.result.serializeAs_ObjectItem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MimicryObjectPreviewMessage(input);
      }
      
      public function deserializeAs_MimicryObjectPreviewMessage(input:IDataInput) : void {
         this.result = new ObjectItem();
         this.result.deserialize(input);
      }
   }
}
