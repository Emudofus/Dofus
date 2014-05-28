package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMountPaddockAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMountPaddockAddMessage() {
         this.mountDescription = new MountClientData();
         super();
      }
      
      public static const protocolId:uint = 6049;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountDescription:MountClientData;
      
      override public function getMessageId() : uint {
         return 6049;
      }
      
      public function initExchangeMountPaddockAddMessage(mountDescription:MountClientData = null) : ExchangeMountPaddockAddMessage {
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
         this.serializeAs_ExchangeMountPaddockAddMessage(output);
      }
      
      public function serializeAs_ExchangeMountPaddockAddMessage(output:IDataOutput) : void {
         this.mountDescription.serializeAs_MountClientData(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeMountPaddockAddMessage(input);
      }
      
      public function deserializeAs_ExchangeMountPaddockAddMessage(input:IDataInput) : void {
         this.mountDescription = new MountClientData();
         this.mountDescription.deserialize(input);
      }
   }
}
