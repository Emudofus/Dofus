package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildGetInformationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildGetInformationsMessage() {
         super();
      }
      
      public static const protocolId:uint = 5550;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var infoType:uint = 0;
      
      override public function getMessageId() : uint {
         return 5550;
      }
      
      public function initGuildGetInformationsMessage(param1:uint=0) : GuildGetInformationsMessage {
         this.infoType = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.infoType = 0;
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
         this.serializeAs_GuildGetInformationsMessage(param1);
      }
      
      public function serializeAs_GuildGetInformationsMessage(param1:IDataOutput) : void {
         param1.writeByte(this.infoType);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildGetInformationsMessage(param1);
      }
      
      public function deserializeAs_GuildGetInformationsMessage(param1:IDataInput) : void {
         this.infoType = param1.readByte();
         if(this.infoType < 0)
         {
            throw new Error("Forbidden value (" + this.infoType + ") on element of GuildGetInformationsMessage.infoType.");
         }
         else
         {
            return;
         }
      }
   }
}
