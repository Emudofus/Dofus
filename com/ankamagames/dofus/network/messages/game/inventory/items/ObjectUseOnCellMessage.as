package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectUseOnCellMessage extends ObjectUseMessage implements INetworkMessage
   {
      
      public function ObjectUseOnCellMessage() {
         super();
      }
      
      public static const protocolId:uint = 3013;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var cells:uint = 0;
      
      override public function getMessageId() : uint {
         return 3013;
      }
      
      public function initObjectUseOnCellMessage(objectUID:uint = 0, cells:uint = 0) : ObjectUseOnCellMessage {
         super.initObjectUseMessage(objectUID);
         this.cells = cells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.cells = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectUseOnCellMessage(output);
      }
      
      public function serializeAs_ObjectUseOnCellMessage(output:IDataOutput) : void {
         super.serializeAs_ObjectUseMessage(output);
         if((this.cells < 0) || (this.cells > 559))
         {
            throw new Error("Forbidden value (" + this.cells + ") on element cells.");
         }
         else
         {
            output.writeShort(this.cells);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectUseOnCellMessage(input);
      }
      
      public function deserializeAs_ObjectUseOnCellMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.cells = input.readShort();
         if((this.cells < 0) || (this.cells > 559))
         {
            throw new Error("Forbidden value (" + this.cells + ") on element of ObjectUseOnCellMessage.cells.");
         }
         else
         {
            return;
         }
      }
   }
}
