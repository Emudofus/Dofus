package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMountStableAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMountStableAddMessage() {
         this.mountDescription = new MountClientData();
         super();
      }
      
      public static const protocolId:uint = 5971;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountDescription:MountClientData;
      
      override public function getMessageId() : uint {
         return 5971;
      }
      
      public function initExchangeMountStableAddMessage(mountDescription:MountClientData=null) : ExchangeMountStableAddMessage {
         this.mountDescription = mountDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountDescription = new MountClientData();
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
         this.serializeAs_ExchangeMountStableAddMessage(output);
      }
      
      public function serializeAs_ExchangeMountStableAddMessage(output:IDataOutput) : void {
         this.mountDescription.serializeAs_MountClientData(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeMountStableAddMessage(input);
      }
      
      public function deserializeAs_ExchangeMountStableAddMessage(input:IDataInput) : void {
         this.mountDescription = new MountClientData();
         this.mountDescription.deserialize(input);
      }
   }
}
