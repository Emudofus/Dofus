package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMountTakenFromPaddockMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMountTakenFromPaddockMessage() {
         super();
      }
      
      public static const protocolId:uint = 5994;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var ownername:String = "";
      
      override public function getMessageId() : uint {
         return 5994;
      }
      
      public function initExchangeMountTakenFromPaddockMessage(param1:String="", param2:int=0, param3:int=0, param4:String="") : ExchangeMountTakenFromPaddockMessage {
         this.name = param1;
         this.worldX = param2;
         this.worldY = param3;
         this.ownername = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.name = "";
         this.worldX = 0;
         this.worldY = 0;
         this.ownername = "";
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
         this.serializeAs_ExchangeMountTakenFromPaddockMessage(param1);
      }
      
      public function serializeAs_ExchangeMountTakenFromPaddockMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.name);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            param1.writeShort(this.worldX);
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               param1.writeShort(this.worldY);
               param1.writeUTF(this.ownername);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeMountTakenFromPaddockMessage(param1);
      }
      
      public function deserializeAs_ExchangeMountTakenFromPaddockMessage(param1:IDataInput) : void {
         this.name = param1.readUTF();
         this.worldX = param1.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeMountTakenFromPaddockMessage.worldX.");
         }
         else
         {
            this.worldY = param1.readShort();
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeMountTakenFromPaddockMessage.worldY.");
            }
            else
            {
               this.ownername = param1.readUTF();
               return;
            }
         }
      }
   }
}
