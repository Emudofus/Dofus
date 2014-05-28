package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PaddockToSellListRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockToSellListRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6141;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var pageIndex:uint = 0;
      
      override public function getMessageId() : uint {
         return 6141;
      }
      
      public function initPaddockToSellListRequestMessage(pageIndex:uint = 0) : PaddockToSellListRequestMessage {
         this.pageIndex = pageIndex;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.pageIndex = 0;
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
         this.serializeAs_PaddockToSellListRequestMessage(output);
      }
      
      public function serializeAs_PaddockToSellListRequestMessage(output:IDataOutput) : void {
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
         }
         else
         {
            output.writeShort(this.pageIndex);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockToSellListRequestMessage(input);
      }
      
      public function deserializeAs_PaddockToSellListRequestMessage(input:IDataInput) : void {
         this.pageIndex = input.readShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of PaddockToSellListRequestMessage.pageIndex.");
         }
         else
         {
            return;
         }
      }
   }
}
