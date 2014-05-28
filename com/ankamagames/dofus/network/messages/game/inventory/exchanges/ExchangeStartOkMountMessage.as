package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkMountMessage extends ExchangeStartOkMountWithOutPaddockMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkMountMessage() {
         this.paddockedMountsDescription = new Vector.<MountClientData>();
         super();
      }
      
      public static const protocolId:uint = 5979;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var paddockedMountsDescription:Vector.<MountClientData>;
      
      override public function getMessageId() : uint {
         return 5979;
      }
      
      public function initExchangeStartOkMountMessage(stabledMountsDescription:Vector.<MountClientData> = null, paddockedMountsDescription:Vector.<MountClientData> = null) : ExchangeStartOkMountMessage {
         super.initExchangeStartOkMountWithOutPaddockMessage(stabledMountsDescription);
         this.paddockedMountsDescription = paddockedMountsDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.paddockedMountsDescription = new Vector.<MountClientData>();
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
         this.serializeAs_ExchangeStartOkMountMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkMountMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output);
         output.writeShort(this.paddockedMountsDescription.length);
         var _i1:uint = 0;
         while(_i1 < this.paddockedMountsDescription.length)
         {
            (this.paddockedMountsDescription[_i1] as MountClientData).serializeAs_MountClientData(output);
            _i1++;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkMountMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkMountMessage(input:IDataInput) : void {
         var _item1:MountClientData = null;
         super.deserialize(input);
         var _paddockedMountsDescriptionLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _paddockedMountsDescriptionLen)
         {
            _item1 = new MountClientData();
            _item1.deserialize(input);
            this.paddockedMountsDescription.push(_item1);
            _i1++;
         }
      }
   }
}
