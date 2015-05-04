package com.ankamagames.dofus.network.messages.game.ui
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ClientUIOpenedByObjectMessage extends ClientUIOpenedMessage implements INetworkMessage
   {
      
      public function ClientUIOpenedByObjectMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6463;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var uid:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6463;
      }
      
      public function initClientUIOpenedByObjectMessage(param1:uint = 0, param2:uint = 0) : ClientUIOpenedByObjectMessage
      {
         super.initClientUIOpenedMessage(param1);
         this.uid = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.uid = 0;
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ClientUIOpenedByObjectMessage(param1);
      }
      
      public function serializeAs_ClientUIOpenedByObjectMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ClientUIOpenedMessage(param1);
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         else
         {
            param1.writeVarInt(this.uid);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ClientUIOpenedByObjectMessage(param1);
      }
      
      public function deserializeAs_ClientUIOpenedByObjectMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.uid = param1.readVarUhInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of ClientUIOpenedByObjectMessage.uid.");
         }
         else
         {
            return;
         }
      }
   }
}
