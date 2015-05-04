package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SetEnableAVARequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SetEnableAVARequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6443;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 6443;
      }
      
      public function initSetEnableAVARequestMessage(param1:Boolean = false) : SetEnableAVARequestMessage
      {
         this.enable = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enable = false;
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
         this.serializeAs_SetEnableAVARequestMessage(param1);
      }
      
      public function serializeAs_SetEnableAVARequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.enable);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SetEnableAVARequestMessage(param1);
      }
      
      public function deserializeAs_SetEnableAVARequestMessage(param1:ICustomDataInput) : void
      {
         this.enable = param1.readBoolean();
      }
   }
}
