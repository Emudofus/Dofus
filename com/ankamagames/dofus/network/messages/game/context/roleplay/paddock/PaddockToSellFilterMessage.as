package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PaddockToSellFilterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockToSellFilterMessage() {
         super();
      }
      
      public static const protocolId:uint = 6161;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var areaId:int = 0;
      
      public var atLeastNbMount:int = 0;
      
      public var atLeastNbMachine:int = 0;
      
      public var maxPrice:uint = 0;
      
      override public function getMessageId() : uint {
         return 6161;
      }
      
      public function initPaddockToSellFilterMessage(areaId:int = 0, atLeastNbMount:int = 0, atLeastNbMachine:int = 0, maxPrice:uint = 0) : PaddockToSellFilterMessage {
         this.areaId = areaId;
         this.atLeastNbMount = atLeastNbMount;
         this.atLeastNbMachine = atLeastNbMachine;
         this.maxPrice = maxPrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.areaId = 0;
         this.atLeastNbMount = 0;
         this.atLeastNbMachine = 0;
         this.maxPrice = 0;
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
         this.serializeAs_PaddockToSellFilterMessage(output);
      }
      
      public function serializeAs_PaddockToSellFilterMessage(output:IDataOutput) : void {
         output.writeInt(this.areaId);
         output.writeByte(this.atLeastNbMount);
         output.writeByte(this.atLeastNbMachine);
         if(this.maxPrice < 0)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element maxPrice.");
         }
         else
         {
            output.writeInt(this.maxPrice);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockToSellFilterMessage(input);
      }
      
      public function deserializeAs_PaddockToSellFilterMessage(input:IDataInput) : void {
         this.areaId = input.readInt();
         this.atLeastNbMount = input.readByte();
         this.atLeastNbMachine = input.readByte();
         this.maxPrice = input.readInt();
         if(this.maxPrice < 0)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element of PaddockToSellFilterMessage.maxPrice.");
         }
         else
         {
            return;
         }
      }
   }
}
