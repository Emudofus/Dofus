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
      
      public function initMountRenameRequestMessage(name:String="", mountId:Number=0) : MountRenameRequestMessage {
         this.name = name;
         this.mountId = mountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.name = "";
         this.mountId = 0;
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
         this.serializeAs_MountRenameRequestMessage(output);
      }
      
      public function serializeAs_MountRenameRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.name);
         output.writeDouble(this.mountId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountRenameRequestMessage(input);
      }
      
      public function deserializeAs_MountRenameRequestMessage(input:IDataInput) : void {
         this.name = input.readUTF();
         this.mountId = input.readDouble();
      }
   }
}
