package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MountRenamedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountRenamedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5983;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var mountId:int = 0;
      
      public var name:String = "";
      
      override public function getMessageId() : uint
      {
         return 5983;
      }
      
      public function initMountRenamedMessage(param1:int = 0, param2:String = "") : MountRenamedMessage
      {
         this.mountId = param1;
         this.name = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountId = 0;
         this.name = "";
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
         this.serializeAs_MountRenamedMessage(param1);
      }
      
      public function serializeAs_MountRenamedMessage(param1:ICustomDataOutput) : void
      {
         param1.writeVarInt(this.mountId);
         param1.writeUTF(this.name);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MountRenamedMessage(param1);
      }
      
      public function deserializeAs_MountRenamedMessage(param1:ICustomDataInput) : void
      {
         this.mountId = param1.readVarInt();
         this.name = param1.readUTF();
      }
   }
}
