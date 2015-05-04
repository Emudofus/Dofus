package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class JobAllowMultiCraftRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobAllowMultiCraftRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5748;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var enabled:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5748;
      }
      
      public function initJobAllowMultiCraftRequestMessage(param1:Boolean = false) : JobAllowMultiCraftRequestMessage
      {
         this.enabled = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enabled = false;
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
         this.serializeAs_JobAllowMultiCraftRequestMessage(param1);
      }
      
      public function serializeAs_JobAllowMultiCraftRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.enabled);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_JobAllowMultiCraftRequestMessage(param1);
      }
      
      public function deserializeAs_JobAllowMultiCraftRequestMessage(param1:ICustomDataInput) : void
      {
         this.enabled = param1.readBoolean();
      }
   }
}
