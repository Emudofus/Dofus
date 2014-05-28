package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountRenamedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountRenamedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5983;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountId:Number = 0;
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 5983;
      }
      
      public function initMountRenamedMessage(mountId:Number = 0, name:String = "") : MountRenamedMessage {
         this.mountId = mountId;
         this.name = name;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountId = 0;
         this.name = "";
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
         this.serializeAs_MountRenamedMessage(output);
      }
      
      public function serializeAs_MountRenamedMessage(output:IDataOutput) : void {
         output.writeDouble(this.mountId);
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountRenamedMessage(input);
      }
      
      public function deserializeAs_MountRenamedMessage(input:IDataInput) : void {
         this.mountId = input.readDouble();
         this.name = input.readUTF();
      }
   }
}
