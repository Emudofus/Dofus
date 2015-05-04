package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ReloginTokenStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ReloginTokenStatusMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6539;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var validToken:Boolean = false;
      
      public var token:String = "";
      
      override public function getMessageId() : uint
      {
         return 6539;
      }
      
      public function initReloginTokenStatusMessage(param1:Boolean = false, param2:String = "") : ReloginTokenStatusMessage
      {
         this.validToken = param1;
         this.token = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.validToken = false;
         this.token = "";
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
         this.serializeAs_ReloginTokenStatusMessage(param1);
      }
      
      public function serializeAs_ReloginTokenStatusMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.validToken);
         param1.writeUTF(this.token);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ReloginTokenStatusMessage(param1);
      }
      
      public function deserializeAs_ReloginTokenStatusMessage(param1:ICustomDataInput) : void
      {
         this.validToken = param1.readBoolean();
         this.token = param1.readUTF();
      }
   }
}
