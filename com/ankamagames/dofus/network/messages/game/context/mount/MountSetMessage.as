package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class MountSetMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function MountSetMessage() {
         this.mountData=new MountClientData();
         super();
      }

      public static const protocolId:uint = 5968;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var mountData:MountClientData;

      override public function getMessageId() : uint {
         return 5968;
      }

      public function initMountSetMessage(mountData:MountClientData=null) : MountSetMessage {
         this.mountData=mountData;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.mountData=new MountClientData();
         this._isInitialized=false;
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
         this.serializeAs_MountSetMessage(output);
      }

      public function serializeAs_MountSetMessage(output:IDataOutput) : void {
         this.mountData.serializeAs_MountClientData(output);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountSetMessage(input);
      }

      public function deserializeAs_MountSetMessage(input:IDataInput) : void {
         this.mountData=new MountClientData();
         this.mountData.deserialize(input);
      }
   }

}