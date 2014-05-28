package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkMountWithOutPaddockMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkMountWithOutPaddockMessage() {
         this.stabledMountsDescription = new Vector.<MountClientData>();
         super();
      }
      
      public static const protocolId:uint = 5991;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var stabledMountsDescription:Vector.<MountClientData>;
      
      override public function getMessageId() : uint {
         return 5991;
      }
      
      public function initExchangeStartOkMountWithOutPaddockMessage(stabledMountsDescription:Vector.<MountClientData> = null) : ExchangeStartOkMountWithOutPaddockMessage {
         this.stabledMountsDescription = stabledMountsDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.stabledMountsDescription = new Vector.<MountClientData>();
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
         this.serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output:IDataOutput) : void {
         output.writeShort(this.stabledMountsDescription.length);
         var _i1:uint = 0;
         while(_i1 < this.stabledMountsDescription.length)
         {
            (this.stabledMountsDescription[_i1] as MountClientData).serializeAs_MountClientData(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(input:IDataInput) : void {
         var _item1:MountClientData = null;
         var _stabledMountsDescriptionLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _stabledMountsDescriptionLen)
         {
            _item1 = new MountClientData();
            _item1.deserialize(input);
            this.stabledMountsDescription.push(_item1);
            _i1++;
         }
      }
   }
}
