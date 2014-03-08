package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PaddockMoveItemRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockMoveItemRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6052;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var oldCellId:uint = 0;
      
      public var newCellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6052;
      }
      
      public function initPaddockMoveItemRequestMessage(param1:uint=0, param2:uint=0) : PaddockMoveItemRequestMessage {
         this.oldCellId = param1;
         this.newCellId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.oldCellId = 0;
         this.newCellId = 0;
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
         this.serializeAs_PaddockMoveItemRequestMessage(param1);
      }
      
      public function serializeAs_PaddockMoveItemRequestMessage(param1:IDataOutput) : void {
         if(this.oldCellId < 0 || this.oldCellId > 559)
         {
            throw new Error("Forbidden value (" + this.oldCellId + ") on element oldCellId.");
         }
         else
         {
            param1.writeShort(this.oldCellId);
            if(this.newCellId < 0 || this.newCellId > 559)
            {
               throw new Error("Forbidden value (" + this.newCellId + ") on element newCellId.");
            }
            else
            {
               param1.writeShort(this.newCellId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PaddockMoveItemRequestMessage(param1);
      }
      
      public function deserializeAs_PaddockMoveItemRequestMessage(param1:IDataInput) : void {
         this.oldCellId = param1.readShort();
         if(this.oldCellId < 0 || this.oldCellId > 559)
         {
            throw new Error("Forbidden value (" + this.oldCellId + ") on element of PaddockMoveItemRequestMessage.oldCellId.");
         }
         else
         {
            this.newCellId = param1.readShort();
            if(this.newCellId < 0 || this.newCellId > 559)
            {
               throw new Error("Forbidden value (" + this.newCellId + ") on element of PaddockMoveItemRequestMessage.newCellId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
