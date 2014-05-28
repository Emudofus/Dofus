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
      
      public function initExchangeMountTakenFromPaddockMessage(name:String = "", worldX:int = 0, worldY:int = 0, ownername:String = "") : ExchangeMountTakenFromPaddockMessage {
         this.name = name;
         this.worldX = worldX;
         this.worldY = worldY;
         this.ownername = ownername;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeMountTakenFromPaddockMessage(output);
      }
      
      public function serializeAs_ExchangeMountTakenFromPaddockMessage(output:IDataOutput) : void {
         output.writeUTF(this.name);
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               output.writeUTF(this.ownername);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeMountTakenFromPaddockMessage(input);
      }
      
      public function deserializeAs_ExchangeMountTakenFromPaddockMessage(input:IDataInput) : void {
         this.name = input.readUTF();
         this.worldX = input.readShort();
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeMountTakenFromPaddockMessage.worldX.");
         }
         else
         {
            this.worldY = input.readShort();
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeMountTakenFromPaddockMessage.worldY.");
            }
            else
            {
               this.ownername = input.readUTF();
               return;
            }
         }
      }
   }
}
