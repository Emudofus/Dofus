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
      
      public function initMountRenamedMessage(param1:Number=0, param2:String="") : MountRenamedMessage {
         this.mountId = param1;
         this.name = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountId = 0;
         this.name = "";
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
         this.serializeAs_MountRenamedMessage(param1);
      }
      
      public function serializeAs_MountRenamedMessage(param1:IDataOutput) : void {
         param1.writeDouble(this.mountId);
         param1.writeUTF(this.name);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MountRenamedMessage(param1);
      }
      
      public function deserializeAs_MountRenamedMessage(param1:IDataInput) : void {
         this.mountId = param1.readDouble();
         this.name = param1.readUTF();
      }
   }
}
