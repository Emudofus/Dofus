package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseToSellListRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseToSellListRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6139;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var pageIndex:uint = 0;
      
      override public function getMessageId() : uint {
         return 6139;
      }
      
      public function initHouseToSellListRequestMessage(pageIndex:uint=0) : HouseToSellListRequestMessage {
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
         this.serializeAs_HouseToSellListRequestMessage(output);
      }
      
      public function serializeAs_HouseToSellListRequestMessage(output:IDataOutput) : void {
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
         this.deserializeAs_HouseToSellListRequestMessage(input);
      }
      
      public function deserializeAs_HouseToSellListRequestMessage(input:IDataInput) : void {
         this.pageIndex = input.readShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of HouseToSellListRequestMessage.pageIndex.");
         }
         else
         {
            return;
         }
      }
   }
}
