package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountRenameRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountRenameRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5987;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      public var mountId:Number = 0;
      
      override public function getMessageId() : uint {
         return 5987;
      }
      
      public function initMountRenameRequestMessage(param1:String="", param2:Number=0) : MountRenameRequestMessage {
         this.name = param1;
         this.mountId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.name = "";
         this.mountId = 0;
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
         this.serializeAs_MountRenameRequestMessage(param1);
      }
      
      public function serializeAs_MountRenameRequestMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.name);
         param1.writeDouble(this.mountId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MountRenameRequestMessage(param1);
      }
      
      public function deserializeAs_MountRenameRequestMessage(param1:IDataInput) : void {
         this.name = param1.readUTF();
         this.mountId = param1.readDouble();
      }
   }
}
