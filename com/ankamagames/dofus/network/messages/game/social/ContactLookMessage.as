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
      
      public function initContactLookMessage(requestId:uint = 0, playerName:String = "", playerId:uint = 0, look:EntityLook = null) : ContactLookMessage {
         this.requestId = requestId;
         this.playerName = playerName;
         this.playerId = playerId;
         this.look = look;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ContactLookMessage(output);
      }
      
      public function serializeAs_ContactLookMessage(output:IDataOutput) : void {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            output.writeInt(this.requestId);
            output.writeUTF(this.playerName);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               output.writeInt(this.playerId);
               this.look.serializeAs_EntityLook(output);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ContactLookMessage(input);
      }
      
      public function deserializeAs_ContactLookMessage(input:IDataInput) : void {
         this.requestId = input.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookMessage.requestId.");
         }
         else
         {
            this.playerName = input.readUTF();
            this.playerId = input.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of ContactLookMessage.playerId.");
            }
            else
            {
               this.look = new EntityLook();
               this.look.deserialize(input);
               return;
            }
         }
      }
   }
}
