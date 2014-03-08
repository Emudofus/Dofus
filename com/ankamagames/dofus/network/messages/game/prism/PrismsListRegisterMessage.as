package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismsListRegisterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismsListRegisterMessage() {
         super();
      }
      
      public static const protocolId:uint = 6441;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var listen:uint = 0;
      
      override public function getMessageId() : uint {
         return 6441;
      }
      
      public function initPrismsListRegisterMessage(param1:uint=0) : PrismsListRegisterMessage {
         this.listen = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.listen = 0;
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
         this.serializeAs_PrismsListRegisterMessage(param1);
      }
      
      public function serializeAs_PrismsListRegisterMessage(param1:IDataOutput) : void {
         param1.writeByte(this.listen);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismsListRegisterMessage(param1);
      }
      
      public function deserializeAs_PrismsListRegisterMessage(param1:IDataInput) : void {
         this.listen = param1.readByte();
         if(this.listen < 0)
         {
            throw new Error("Forbidden value (" + this.listen + ") on element of PrismsListRegisterMessage.listen.");
         }
         else
         {
            return;
         }
      }
   }
}
