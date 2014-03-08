package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NumericWhoIsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NumericWhoIsMessage() {
         super();
      }
      
      public static const protocolId:uint = 6297;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playerId:uint = 0;
      
      public var accountId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6297;
      }
      
      public function initNumericWhoIsMessage(param1:uint=0, param2:uint=0) : NumericWhoIsMessage {
         this.playerId = param1;
         this.accountId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerId = 0;
         this.accountId = 0;
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
         this.serializeAs_NumericWhoIsMessage(param1);
      }
      
      public function serializeAs_NumericWhoIsMessage(param1:IDataOutput) : void {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            if(this.accountId < 0)
            {
               throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
            }
            else
            {
               param1.writeInt(this.accountId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_NumericWhoIsMessage(param1);
      }
      
      public function deserializeAs_NumericWhoIsMessage(param1:IDataInput) : void {
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of NumericWhoIsMessage.playerId.");
         }
         else
         {
            this.accountId = param1.readInt();
            if(this.accountId < 0)
            {
               throw new Error("Forbidden value (" + this.accountId + ") on element of NumericWhoIsMessage.accountId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
