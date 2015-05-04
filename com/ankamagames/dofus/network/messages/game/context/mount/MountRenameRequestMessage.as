package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MountRenameRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountRenameRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5987;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      public var mountId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5987;
      }
      
      public function initMountRenameRequestMessage(param1:String = "", param2:int = 0) : MountRenameRequestMessage
      {
         this.name = param1;
         this.mountId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.name = "";
         this.mountId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MountRenameRequestMessage(param1);
      }
      
      public function serializeAs_MountRenameRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.name);
         param1.writeVarInt(this.mountId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MountRenameRequestMessage(param1);
      }
      
      public function deserializeAs_MountRenameRequestMessage(param1:ICustomDataInput) : void
      {
         this.name = param1.readUTF();
         this.mountId = param1.readVarInt();
      }
   }
}
