package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MimicryObjectAssociatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MimicryObjectAssociatedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6462;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var hostUID:uint = 0;
      
      override public function getMessageId() : uint {
         return 6462;
      }
      
      public function initMimicryObjectAssociatedMessage(param1:uint=0) : MimicryObjectAssociatedMessage {
         this.hostUID = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.hostUID = 0;
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
         this.serializeAs_MimicryObjectAssociatedMessage(param1);
      }
      
      public function serializeAs_MimicryObjectAssociatedMessage(param1:IDataOutput) : void {
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element hostUID.");
         }
         else
         {
            param1.writeInt(this.hostUID);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MimicryObjectAssociatedMessage(param1);
      }
      
      public function deserializeAs_MimicryObjectAssociatedMessage(param1:IDataInput) : void {
         this.hostUID = param1.readInt();
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element of MimicryObjectAssociatedMessage.hostUID.");
         }
         else
         {
            return;
         }
      }
   }
}
