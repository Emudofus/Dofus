package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ContactLookMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ContactLookMessage() {
         this.look = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 5934;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var requestId:uint = 0;
      
      public var playerName:String = "";
      
      public var playerId:uint = 0;
      
      public var look:EntityLook;
      
      override public function getMessageId() : uint {
         return 5934;
      }
      
      public function initContactLookMessage(param1:uint=0, param2:String="", param3:uint=0, param4:EntityLook=null) : ContactLookMessage {
         this.requestId = param1;
         this.playerName = param2;
         this.playerId = param3;
         this.look = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.requestId = 0;
         this.playerName = "";
         this.playerId = 0;
         this.look = new EntityLook();
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
         this.serializeAs_ContactLookMessage(param1);
      }
      
      public function serializeAs_ContactLookMessage(param1:IDataOutput) : void {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            param1.writeInt(this.requestId);
            param1.writeUTF(this.playerName);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               param1.writeInt(this.playerId);
               this.look.serializeAs_EntityLook(param1);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ContactLookMessage(param1);
      }
      
      public function deserializeAs_ContactLookMessage(param1:IDataInput) : void {
         this.requestId = param1.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookMessage.requestId.");
         }
         else
         {
            this.playerName = param1.readUTF();
            this.playerId = param1.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of ContactLookMessage.playerId.");
            }
            else
            {
               this.look = new EntityLook();
               this.look.deserialize(param1);
               return;
            }
         }
      }
   }
}
